import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/track_order/presentation/cubit/track_order_cubit.dart';
import 'package:flower/features/track_order/presentation/cubit/track_order_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmDeliveryButton extends StatelessWidget {
  final String orderId;

  const ConfirmDeliveryButton({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<TrackOrderCubit, bool>(
      (c) => c.state.confirmDeliveryState.isLoading,
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                context.read<TrackOrderCubit>().doEvent(
                      ConfirmDelivery(orderId: orderId),
                    );
              },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textWhite),
              )
            : Text(
                TrackOrderConstants.confirmDelivery,
                style: getSemiBoldStyle(context: context, fontSize: 16, color: AppColors.textWhite),
              ),
      ),
    );
  }
}
