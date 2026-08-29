import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower/features/cart/presentation/cubit/cart_events.dart';
import 'package:flower/features/cart/presentation/cubit/cart_state.dart';
import 'package:flower/features/cart/presentation/widgets/cart_appbar_widget.dart';
import 'package:flower/features/cart/presentation/widgets/cart_item_card_widget.dart';
import 'package:flower/features/cart/presentation/widgets/cart_summary_section_widget.dart';
import 'package:flower/features/cart/presentation/widgets/empty_cart_view_widget.dart';
import 'package:flower/features/address/presentation/saved_addresses/widgets/deliver_to_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    context.read<CartCubit>().onEvent(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CartAppBar(),
      body: BlocListener<CartCubit, CartState>(
        listenWhen: (previous, current) =>
            previous.successMessage != current.successMessage ||
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.successMessage != null &&
              state.successMessage!.isNotEmpty) {
            CustomSnackBar.info(
              context,
              state.successMessage!,
              icon: Icons.delete_outline_rounded,
            );
          }

          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            CustomSnackBar.error(context, state.errorMessage!);
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final items = state.cart?.cart?.cartItems ?? [];

            if (items.isEmpty) {
              return const EmptyCartView();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DeliverToWidget(),

                  const AppSizedBox(height: AppSize.s12),

                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                        top: AppSize.s8,
                        bottom: AppSize.s12,
                      ),
                      itemCount: items.length,
                      separatorBuilder: (_, __) =>
                          const AppSizedBox(height: AppSize.s10),
                      itemBuilder: (context, index) {
                        final item = items[index];

                        if (item.id == null) {
                          return const SizedBox.shrink();
                        }

                        return CartItemCard(
                          key: ValueKey(item.id),
                          itemId: item.id!,
                        );
                      },
                    ),
                  ),

                  CartSummarySection(
                    subtotal: state.cart?.cart?.totalPrice ?? 0,
                  ),

                  const AppSizedBox(height: AppSize.s12),

                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSize.s24),
                    child: PrimaryButton(
                      text: CartConstants.checkOut,
                      onTap: () {
                        final subtotal = state.cart?.cart?.totalPrice ?? 0;

                        Navigator.pushNamed(
                          context,
                          Routes.checkout,
                          arguments: subtotal,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
