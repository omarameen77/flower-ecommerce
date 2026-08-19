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
      (cubit) => cubit.state.confirmDeliveryState.isLoading,
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
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: AppColors.textWhite,
                  ),
                )
              : Row(
                  key: const ValueKey('content'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 21,
                      color: AppColors.textWhite,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      TrackOrderConstants.confirmDelivery,
                      style: getSemiBoldStyle(
                        context: context,
                        fontSize: 16,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
