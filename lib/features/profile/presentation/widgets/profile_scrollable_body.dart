import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/localization_constants/profile_constants.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_event.dart';
import 'package:flower/features/profile/presentation/widgets/profile_language_label.dart';
import 'package:flower/features/profile/presentation/widgets/profile_logout_dialog.dart';
import 'package:flower/features/profile/presentation/widgets/profile_menu_row.dart';
import 'package:flower/features/profile/presentation/widgets/profile_user_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScrollableBody extends StatelessWidget {
  const ProfileScrollableBody({super.key});

  static const double _horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocSelector<ProfileCubit, ProfileState, BaseState<UserEntity>>(
                selector: (state) => state.profileState,
                builder: (context, profileState) {
                  return ProfileUserHeader(profileState: profileState);
                },
              ),
              AppSizedBox(height: 24),
              ProfileMenuRow(
                leading: SvgPicture.asset(
                  AppSvgs.myOrders,
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                title: ProfileConstants.myOrders,
                onTap: () {},
              ),
              AppSizedBox(height: 14),
              ProfileMenuRow(
                leading: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                ),
                title: ProfileConstants.savedAddress,
                onTap: () {},
              ),
              AppSizedBox(height: 16),
            ],
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSizedBox(height: 16),
              BlocSelector<ProfileCubit, ProfileState, bool>(
                selector: (state) => state.notificationsEnabled,
                builder: (context, notificationsEnabled) {
                  return Row(
                    children: [
                      Switch(
                        value: notificationsEnabled,
                        activeThumbColor: AppColors.primary,
                        onChanged: (value) => context
                            .read<ProfileCubit>()
                            .doEvent(NotificationsChanged(value)),
                      ),
                      Expanded(
                        child: Text(
                          ProfileConstants.notifications,
                          style: getRegularStyle(
                            context: context,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Colors.black,
                      ),
                    ],
                  );
                },
              ),
              AppSizedBox(height: 16),
            ],
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSizedBox(height: 8),
              BlocSelector<ProfileCubit, ProfileState, String>(
                selector: (state) => state.languageCode,
                builder: (context, languageCode) {
                  return ProfileMenuRow(
                    leading: const Icon(Icons.language, color: Colors.black),
                    title: ProfileConstants.language,
                    trailing: Text(
                      profileLanguageLabel(languageCode),
                      style: getMediumStyle(
                        context: context,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    onTap: () => context.read<ProfileCubit>().doEvent(
                      const ToggleLanguage(),
                    ),
                  );
                },
              ),
              AppSizedBox(height: 8),
              ProfileMenuRow(title: ProfileConstants.aboutUs, onTap: () {}),
              AppSizedBox(height: 8),
              ProfileMenuRow(
                title: ProfileConstants.termsConditions,
                onTap: () {},
              ),
              AppSizedBox(height: 16),
            ],
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSizedBox(height: 12),
              ProfileMenuRow(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 20,
                ),
                title: ProfileConstants.logout,
                trailing: const Icon(Icons.logout, color: Colors.black),
                onTap: () => showProfileLogoutDialogIfConfirmed(context),
              ),
              AppSizedBox(height: 32),
              Center(
                child: Text(
                  ProfileConstants.version,
                  style: getRegularStyle(
                    context: context,
                    fontSize: FontSizeManager.s12,
                    color: AppColors.grey700,
                  ),
                ),
              ),
              AppSizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
