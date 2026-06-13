import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/checkout_and_orders/presentation/checkout/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutBottomButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CheckoutBottomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final status = context.select<CheckoutCubit, CheckoutStatus>(
      (c) => c.state.status,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSize.s16,
        AppSize.s12,
        AppSize.s16,
        AppSize.s24,
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppSize.s50,
        child: switch (status) {
          CheckoutStatus.loading => const ButtonLoadingWidget(),
          CheckoutStatus.paymentPending => PrimaryButton(
            text: CheckoutConstants.paymentCompleted,
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.thankYou),
          ),
          _ => PrimaryButton(text: CheckoutConstants.placeOrder, onTap: onTap),
        },
      ),
    );
  }
}
