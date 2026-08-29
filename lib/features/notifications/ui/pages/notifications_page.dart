import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/localization_constants/notifications_constants.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_cubit.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_event.dart';
import 'package:flower/features/notifications/ui/widgets/notifications_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<NotificationsCubit>()..onEvent(GetNotificationsEvent()),
      child: Scaffold(
        appBar: CustomAppBar(title: NotificationsConstants.title),
        body: const NotificationsBody(),
      ),
    );
  }
}
