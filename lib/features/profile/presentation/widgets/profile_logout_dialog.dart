import 'package:flower/core/localization_constants/profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_event.dart';

Future<void> showProfileLogoutDialogIfConfirmed(BuildContext context) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.10),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.logout_rounded, color: AppColors.error),
        ),
        title: Text(
          ProfileConstants.logoutTitle,
          textAlign: TextAlign.center,
          style: getSemiBoldStyle(
            context: dialogContext,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          ProfileConstants.logoutMessage,
          textAlign: TextAlign.center,
          style: getRegularStyle(
            context: dialogContext,
            color: AppColors.textSecondary,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              ProfileConstants.cancel,
              style: getMediumStyle(
                context: dialogContext,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              ProfileConstants.logout,
              style: getMediumStyle(
                context: dialogContext,
                color: Colors.white,
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
