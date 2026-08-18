import 'package:flower/config/routes/routes.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/localization_constants/profile_constants.dart';
import 'package:flower/core/network/model/user_entity.dart';
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
      padding: const EdgeInsets.fromLTRB(
        _horizontalPadding,
        16,
        _horizontalPadding,
        24,
      ),
      children: [
        BlocSelector<ProfileCubit, ProfileState, BaseState<UserEntity>>(
          selector: (state) => state.profileState,
          builder: (context, profileState) {
            return ProfileUserHeader(
              profileState: profileState,
              onEditProfileTap: () {
                final user = context
                    .read<ProfileCubit>()
                    .state
                    .profileState
                    .data;
                if (user == null) return;
                Navigator.pushNamed(
                  context,
                  Routes.editProfile,
                  arguments: user,
                ).then((updated) {
                  if (updated == true && context.mounted) {
                    context.read<ProfileCubit>().doEvent(const LoadProfile());
                  }
                });
              },
            );
          },
        ),
        const AppSizedBox(height: 28),

        _SectionCard(
          children: [
            ProfileMenuRow(
              iconBackgroundColor: AppColors.primary.withOpacity(0.10),
              leading: SvgPicture.asset(
                AppSvgs.cart,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              title: ProfileConstants.myOrders,
              onTap: () => Navigator.pushNamed(context, Routes.orders),
            ),
            const _RowDivider(),
            ProfileMenuRow(
              iconBackgroundColor: AppColors.primary.withOpacity(0.10),
              leading: Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              title: ProfileConstants.savedAddress,
              onTap: () => Navigator.pushNamed(context, Routes.savedAddresses),
            ),
          ],
        ),
        const AppSizedBox(height: 16),

        _SectionCard(
          children: [
            BlocSelector<ProfileCubit, ProfileState, bool>(
              selector: (state) => state.notificationsEnabled,
              builder: (context, notificationsEnabled) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      const AppSizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.notifications,
                          ),
                          child: Row(
                            children: [
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
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const AppSizedBox(width: 8),
                      Switch.adaptive(
                        value: notificationsEnabled,
                        activeThumbColor: AppColors.primary,
                        onChanged: (value) => context
                            .read<ProfileCubit>()
                            .doEvent(NotificationsChanged(value)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        const AppSizedBox(height: 16),

        _SectionCard(
          children: [
            BlocSelector<ProfileCubit, ProfileState, String>(
              selector: (state) => state.languageCode,
              builder: (context, languageCode) {
                return ProfileMenuRow(
                  iconBackgroundColor: AppColors.primary.withOpacity(0.10),
                  leading: Icon(
                    Icons.language_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  title: ProfileConstants.language,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        profileLanguageLabel(languageCode),
                        style: getMediumStyle(
                          context: context,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const AppSizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  onTap: () => context.read<ProfileCubit>().doEvent(
                    const ToggleLanguage(),
                  ),
                );
              },
            ),
            const _RowDivider(),
            ProfileMenuRow(
              title: ProfileConstants.aboutUs,
              onTap: () => Navigator.pushNamed(context, Routes.aboutUs),
            ),
            const _RowDivider(),
            ProfileMenuRow(
              title: ProfileConstants.termsConditions,
              onTap: () => Navigator.pushNamed(context, Routes.termsConditions),
            ),
          ],
        ),
        const AppSizedBox(height: 16),

        _SectionCard(
          children: [
            ProfileMenuRow(
              iconBackgroundColor: AppColors.error.withOpacity(0.10),
              leading: Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: 20,
              ),
              title: ProfileConstants.logout,
              trailing: const SizedBox.shrink(),
              titleColor: AppColors.error,
              onTap: () => showProfileLogoutDialogIfConfirmed(context),
            ),
          ],
        ),

        const AppSizedBox(height: 28),
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
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, thickness: 1, color: Color(0x11000000)),
    );
  }
}
