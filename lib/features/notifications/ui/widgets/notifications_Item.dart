import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/notification_date_formatter.dart';
import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final NotificationsEntity notification;

  const NotificationItem({super.key, required this.notification});

  bool get isUnread => !notification.isRead;

  IconData _notificationIcon() {
    switch (notification.type) {
      case "offer":
        return Icons.local_offer_rounded;

      case "order":
        return Icons.shopping_bag_rounded;

      case "driver_arrived":
        return Icons.local_shipping_rounded;

      case "payment":
        return Icons.payments_rounded;

      case "message":
        return Icons.chat_bubble_rounded;

      default:
        return Icons.notifications_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread
            ? AppColors.primary.withValues(alpha: .08)
            : AppColors.background,
        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: isUnread
              ? AppColors.primary.withValues(alpha: .15)
              : Colors.transparent,
        ),

        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.black.withValues(alpha: .04),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _notificationIcon(),
            size: 28,
            color: isUnread ? AppColors.primary : AppColors.grey600,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: isUnread
                            ? getBoldStyle(
                                context: context,
                                color: AppColors.textPrimary,
                                fontSize: 16,
                              )
                            : getMediumStyle(
                                context: context,
                                color: AppColors.textPrimary,
                                fontSize: 16,
                              ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      NotificationDateFormatter.format(notification.createdAt),
                      style: getRegularStyle(
                        context: context,
                        color: AppColors.textPrimary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  notification.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getRegularStyle(
                    context: context,
                    color: AppColors.grey800,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isUnread ? 1 : 0,
            child: Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(top: 6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
