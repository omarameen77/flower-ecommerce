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
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logout Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  size: 30,
                  color: AppColors.error,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Text(
                ProfileConstants.logoutTitle,
                textAlign: TextAlign.center,
                style: getSemiBoldStyle(
                  context: dialogContext,
                  color: AppColors.textPrimary,
                ).copyWith(fontSize: 20),
              ),

              const SizedBox(height: 10),

              // Description
              Text(
                ProfileConstants.logoutMessage,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  context: dialogContext,
                  color: AppColors.textSecondary,
                ).copyWith(fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 26),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop(false);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: BorderSide(
                            color: AppColors.textSecondary.withOpacity(0.25),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
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
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop(true);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  if (context.mounted && shouldLogout == true) {
    context.read<ProfileCubit>().doEvent(const LogoutRequested());
  }
}
