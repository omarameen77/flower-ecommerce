import 'package:flower/core/localization_constants/notifications_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_error_widget.dart';
import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_cubit.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_event.dart';
import 'package:flower/features/notifications/ui/widgets/notifications_Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final viewState = state.notificationsState;

        if (viewState.errorMessage != null && !viewState.isLoading) {
          return AppErrorWidget(
            errorMessage: viewState.errorMessage!,
            retryButtonText: NotificationsConstants.retry,
            onRetry: () {
              context.read<NotificationsCubit>().onEvent(
                GetNotificationsEvent(),
              );
            },
          );
        }

        var notificationsList = viewState.data?.notifications ?? [];

        if (viewState.isLoading) {
          notificationsList = List.generate(
            5,
            (index) => NotificationsEntity(
              id: NotificationsConstants.dummyLoadingId,
              title: NotificationsConstants.dummyLoadingTitle,
              body: NotificationsConstants.dummyLoadingBody,
              isRead: false,
            ),
          );
        }

        if (notificationsList.isEmpty && !viewState.isLoading) {
          return const Center(
            child: Text(NotificationsConstants.noNotificationsFound),
          );
        }

        return Skeletonizer(
          enabled: viewState.isLoading,
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: AppColors.grey600),
            itemCount: notificationsList.length,
            physics: viewState.isLoading
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return NotificationItem(notification: notificationsList[index]);
            },
          ),
        );
      },
    );
  }
}
