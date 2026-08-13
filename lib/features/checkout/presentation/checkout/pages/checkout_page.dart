import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flower/features/checkout/presentation/checkout/cubit/checkout_cubit.dart';
import 'package:flower/features/checkout/presentation/checkout/cubit/checkout_event.dart';
import 'package:flower/features/checkout/presentation/checkout/widgets/checkout_address_card.dart';
import 'package:flower/features/checkout/presentation/checkout/widgets/checkout_bottom_button.dart';
import 'package:flower/features/checkout/presentation/checkout/widgets/checkout_delivery_time.dart';
import 'package:flower/features/checkout/presentation/checkout/widgets/checkout_gift_toggle.dart';
import 'package:flower/features/checkout/presentation/checkout/widgets/checkout_payment_method.dart';
import 'package:flower/features/checkout/presentation/checkout/widgets/checkout_receiver_fields.dart';
import 'package:flower/features/checkout/presentation/checkout/widgets/checkout_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  final int subtotal;

  const CheckoutPage({super.key, required this.subtotal});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SavedAddressesCubit>();
    if (cubit.state.addressesState.data == null &&
        !cubit.state.addressesState.isLoading) {
      cubit.doIntent(const LoadAddressesIntent());
    }
  }

  @override
  void dispose() {
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    final checkoutCubit = context.read<CheckoutCubit>();
    final address = context.read<SavedAddressesCubit>().state.currentAddress;

    if (address == null) {
      CustomSnackBar.error(context, 'Please select a shipping address');
      return;
    }

    final state = checkoutCubit.state;
    final isCard = state.selectedPayment == 1;

    if (isCard) {
      checkoutCubit.doEvent(
        PlaceOrderWithCard(
          street: address.street,
          phone: address.phone,
          city: address.city,
          lat: address.lat,
          long: address.long,
          receiverName: _receiverNameController.text,
          receiverPhone: _receiverPhoneController.text,
        ),
      );
    } else {
      checkoutCubit.doEvent(
        PlaceOrderWithCash(
          street: address.street,
          phone: address.phone,
          city: address.city,
          lat: address.lat,
          long: address.long,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: CheckoutConstants.title),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            (current.status == CheckoutStatus.success ||
                current.status == CheckoutStatus.paymentPending ||
                current.status == CheckoutStatus.error),
        listener: (context, state) {
          switch (state.status) {
            case CheckoutStatus.success:
              Navigator.pushReplacementNamed(context, Routes.thankYou);
            case CheckoutStatus.paymentPending:
              final url = state.paymentUrl;
              if (url != null && url.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  Routes.paymentWebView,
                  arguments: {'url': url, 'successUrl': state.successUrl},
                ).then((success) {
                  if (success == true && context.mounted) {
                    context.read<CheckoutCubit>().doEvent(
                      const PaymentCompleted(),
                    );
                  }
                });
              }
            case CheckoutStatus.error:
              if (state.errorMessage != null) {
                CustomSnackBar.error(context, state.errorMessage!);
              }
            default:
              break;
          }
        },
        child: Column(
          children: [
            Expanded(
              child: _CheckoutForm(
                subtotal: widget.subtotal,
                nameController: _receiverNameController,
                phoneController: _receiverPhoneController,
              ),
            ),
            CheckoutBottomButton(onTap: _placeOrder),
          ],
        ),
      ),
    );
  }
}

class _CheckoutForm extends StatelessWidget {
  final int subtotal;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const _CheckoutForm({
    required this.subtotal,
    required this.nameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    final selectedPayment = context.select<CheckoutCubit, int>(
      (c) => c.state.selectedPayment,
    );
    final isGift = context.select<CheckoutCubit, bool>((c) => c.state.isGift);

    return ListView(
      children: [
        const CheckoutDeliveryTime(),
        const AppSizedBox(height: AppSize.s24),

        const CheckoutAddressCard(),
        const AppSizedBox(height: AppSize.s24),

        CheckoutPaymentMethod(
          selectedIndex: selectedPayment,
          onChanged: (v) =>
              context.read<CheckoutCubit>().doEvent(ChangePaymentMethod(v)),
        ),
        if (selectedPayment == 1) ...[
          const AppSizedBox(height: AppSize.s24),
          CheckoutGiftToggle(
            value: isGift,
            onChanged: (v) =>
                context.read<CheckoutCubit>().doEvent(ToggleGift(v)),
          ),
        ],
        if (isGift && selectedPayment == 1) ...[
          CheckoutReceiverFields(
            nameController: context
                .findAncestorStateOfType<_CheckoutPageState>()!
                ._receiverNameController,
            phoneController: context
                .findAncestorStateOfType<_CheckoutPageState>()!
                ._receiverPhoneController,
          ),
        ],
        const AppSizedBox(height: AppSize.s24),
        CheckoutSummary(subtotal: subtotal),
      ],
    );
  }
}
