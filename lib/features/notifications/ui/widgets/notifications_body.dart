import 'package:flower/core/localization_constants/notifications_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_error_widget.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/core/widgets/loading_dot.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_cubit.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_event.dart';
import 'package:flower/features/notifications/ui/widgets/notifications_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state.errorMessage != null && !state.isLoading) {
          return AppErrorWidget(
            errorMessage: state.errorMessage!,
            retryButtonText: NotificationsConstants.retry,
            onRetry: () {
              context.read<NotificationsCubit>().onEvent(
                GetNotificationsEvent(),
              );
            },
          );
        }

        if (state.isLoading) {
          return const Center(child: LoadingDot());
        }

        if (state.notifications.isEmpty) {
          return const Center(
            child: Text(NotificationsConstants.noNotificationsFound),
          );
        }

        return ListView.separated(
          itemCount: state.notifications.length,
          separatorBuilder: (_, __) =>
              Divider(height: 1, color: AppColors.grey600),
          itemBuilder: (_, index) {
            final notification = state.notifications[index];
            return Dismissible(
              key: ValueKey(notification.id),

              direction: DismissDirection.endToStart,

              background: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.only(right: 24),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),

              onDismissed: (_) async {
                await context.read<NotificationsCubit>().deleteNotification(
                  notification.id,
                );

                CustomSnackBar.info(
                  context,
                  "${"Notification deleted"} ${notification.title}",
                );
              },

              child: GestureDetector(
                onTap: () async {
                  await context.read<NotificationsCubit>().markAsRead(
                    notification.id,
                  );
                },
                child: NotificationItem(notification: notification),
              ),
            );
          },
        );
      },
    );
  }
}
