import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/profile/presentation/widgets/profile_avatar_placeholder.dart';
import 'package:flower/features/profile/presentation/widgets/profile_header_shimmer.dart';
import 'package:flutter/material.dart';

class ProfileUserHeader extends StatelessWidget {
  const ProfileUserHeader({
    super.key,
    required this.profileState,
    this.onEditProfileTap,
  });

  final BaseState<UserEntity> profileState;
  final VoidCallback? onEditProfileTap;

  @override
  Widget build(BuildContext context) {
    final profile = profileState;

    if (profile.isLoading) {
      return const ProfileHeaderShimmer();
    }

    final user = profile.data;
    if (user == null) {
      if (profile.errorMessage != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            profile.errorMessage!,
            textAlign: TextAlign.center,
            style: getRegularStyle(context: context, color: AppColors.error),
          ),
        );
      }
      return const SizedBox.shrink();
    }

    final photo = user.photo;
    final nameParts = <String>[
      if (user.firstName != null && user.firstName!.trim().isNotEmpty)
        user.firstName!.trim(),
      if (user.lastName != null && user.lastName!.trim().isNotEmpty)
        user.lastName!.trim(),
    ];
    final displayName = nameParts.isEmpty ? '—' : nameParts.join(' ');

    const double avatarSize = 108;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.35),
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ProfileAvatarPlaceholder(
                  imageUrl: photo,
                  width: avatarSize,
                  height: avatarSize,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEditProfileTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const AppSizedBox(height: 14),
        Text(
          displayName,
          style: getSemiBoldStyle(
            context: context,
            fontSize: FontSizeManager.s16,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const AppSizedBox(height: 4),
        Text(
          user.email ?? '',
          style: getRegularStyle(
            context: context,
            fontSize: FontSizeManager.s14,
            color: AppColors.grey700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
