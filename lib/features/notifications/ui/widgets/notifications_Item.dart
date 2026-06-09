import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final NotificationsEntity notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: AppColors.background),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0, right: 12.0),
            child: Icon(
              Icons.notifications_none_outlined,
              color: AppColors.grey900,
              size: 24,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title ?? '',
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.textPrimary,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.body ?? '',
                  style: getRegularStyle(
                    context: context,
                    color: AppColors.grey800,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
