import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBellWidget extends StatelessWidget {
  const NotificationBellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final unreadCount = state.unreadCount;
        return badges.Badge(
          showBadge: unreadCount > 0,
          badgeStyle: const badges.BadgeStyle(
            badgeColor: AppColors.error,
            padding: EdgeInsets.all(5),
            elevation: 2,
          ),

          position: badges.BadgePosition.topEnd(top: -5, end: -2),
          badgeContent: Text(
            unreadCount.toString(),
            style: getMediumStyle(
              context: context,
              color: AppColors.surface,
              fontSize: 10,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.notifications);
            },
            child: const Icon(
              Icons.notifications_none_outlined,
              color: AppColors.grey900,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}
