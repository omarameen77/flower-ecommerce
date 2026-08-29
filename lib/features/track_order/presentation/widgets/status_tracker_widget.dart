import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/domain/entities/tracking_status.dart';
import 'package:flutter/material.dart';

class _StatusStep {
  final String label;
  final TrackingStatus key;

  const _StatusStep({required this.label, required this.key});
}

class StatusTrackerWidget extends StatelessWidget {
  final TrackOrderEntity entity;

  const StatusTrackerWidget({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final stateValue =
        entity.state ?? entity.order?.state ?? TrackingStatus.inProgress;

    final steps = [
      _StatusStep(
        label: TrackOrderConstants.inProgress,
        key: TrackingStatus.inProgress,
      ),
      _StatusStep(
        label: TrackOrderConstants.picked,
        key: TrackingStatus.picked,
      ),
      _StatusStep(
        label: TrackOrderConstants.outForDelivery,
        key: TrackingStatus.outForDelivery,
      ),
      _StatusStep(
        label: TrackOrderConstants.arrived,
        key: TrackingStatus.arrived,
      ),
      _StatusStep(
        label: TrackOrderConstants.delivered,
        key: TrackingStatus.completed,
      ),
    ];

    final currentIndex = steps.indexWhere((step) => step.key == stateValue);

    final safeCurrentIndex = currentIndex == -1 ? 0 : currentIndex;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ...List.generate(steps.length, (index) {
            final step = steps[index];

            return _buildStepRow(
              context: context,
              step: step,
              isCompleted: index <= safeCurrentIndex,
              isCurrent: index == safeCurrentIndex,
              index: index,
              isLast: index == steps.length - 1,
              currentIndex: safeCurrentIndex,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStepRow({
    required BuildContext context,
    required _StatusStep step,
    required bool isCompleted,
    required bool isCurrent,
    required int index,
    required bool isLast,
    required int currentIndex,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isCurrent ? 28 : 24,
              height: isCurrent ? 28 : 24,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : AppColors.grey600,
                shape: BoxShape.circle,
                boxShadow: isCurrent
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(
                        Icons.check_rounded,
                        size: 15,
                        color: AppColors.textWhite,
                      )
                    : Text(
                        '${index + 1}',
                        style: getRegularStyle(
                          context: context,
                          fontSize: 12,
                          color: AppColors.textWhite,
                        ),
                      ),
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 38,
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: index < currentIndex
                      ? AppColors.primary
                      : AppColors.grey600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20, top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.label,
                  style: getMediumStyle(
                    context: context,
                    fontSize: 14,
                    color: isCompleted
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),

                if (isCurrent) ...[
                  const SizedBox(height: 6),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      TrackOrderConstants.current,
                      style: getMediumStyle(
                        context: context,
                        fontSize: 11,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
