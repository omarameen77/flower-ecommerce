import 'package:flower/core/localization_constants/profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showProfileLogoutDialogIfConfirmed(BuildContext context) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(
          ProfileConstants.logoutTitle,
          style: getSemiBoldStyle(
            context: dialogContext,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          ProfileConstants.logoutMessage,
          style: getRegularStyle(
            context: dialogContext,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              ProfileConstants.cancel,
              style: getMediumStyle(
                context: dialogContext,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              ProfileConstants.logout,
              style: getMediumStyle(
                context: dialogContext,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      );
    },
  );

  if (context.mounted && shouldLogout == true) {
    context.read<ProfileCubit>().doEvent(const LogoutRequested());
  }
}
