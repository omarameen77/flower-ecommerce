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
    final stateValue = entity.state ?? entity.order?.state ?? TrackingStatus.inProgress;

    final steps = [
      _StatusStep(label: TrackOrderConstants.inProgress, key: TrackingStatus.inProgress),
      _StatusStep(label: TrackOrderConstants.picked, key: TrackingStatus.picked),
      _StatusStep(label: TrackOrderConstants.outForDelivery, key: TrackingStatus.outForDelivery),
      _StatusStep(label: TrackOrderConstants.arrived, key: TrackingStatus.arrived),
      _StatusStep(label: TrackOrderConstants.delivered, key: TrackingStatus.completed),
    ];

    final currentIndex = steps.indexWhere((s) => s.key == stateValue);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TrackOrderConstants.orderStatus,
            style: getSemiBoldStyle(context: context, fontSize: 16, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final isCompleted = index <= currentIndex;
            final isCurrent = index == currentIndex;
            final isLast = index == steps.length - 1;

            return _buildStepRow(context, step, isCompleted, isCurrent, index, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildStepRow(BuildContext context, _StatusStep step, bool isCompleted, bool isCurrent, int index, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : AppColors.grey600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, size: 14, color: AppColors.textWhite)
                    : Text(
                        '${index + 1}',
                        style: getRegularStyle(context: context, fontSize: 12, color: AppColors.textWhite),
                      ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                color: isCompleted ? AppColors.primary : AppColors.grey600,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Padding(
          padding: EdgeInsets.only(bottom: !isLast ? 20 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.label,
                style: getMediumStyle(
                  context: context,
                  fontSize: 14,
                  color: isCompleted ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              if (isCurrent)
                Text(
                  TrackOrderConstants.current,
                  style: getRegularStyle(context: context, fontSize: 12, color: AppColors.primary),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
