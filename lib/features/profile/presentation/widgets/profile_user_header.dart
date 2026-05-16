import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/profile/presentation/widgets/profile_avatar_placeholder.dart';
import 'package:flower/features/profile/presentation/widgets/profile_header_shimmer.dart';
import 'package:flutter/material.dart';

class ProfileUserHeader extends StatelessWidget {
  const ProfileUserHeader({super.key, required this.profileState});

  final BaseState<UserEntity> profileState;

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
            style: getRegularStyle(
              context: context,
              color: AppColors.error,
            ),
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

    return Column(
      children: [
        ProfileAvatarPlaceholder(imageUrl: photo),
        AppSizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayName,
              style: getSemiBoldStyle(
                context: context,
                fontSize: FontSizeManager.s16,
                color: AppColors.textPrimary,
              ),
            ),
            AppSizedBox(width: 6),
            const Icon(Icons.edit_outlined, size: 18, color: Colors.black),
          ],
        ),
        AppSizedBox(height: 6),
        Text(
          user.email ?? '',
          style: getRegularStyle(
            context: context,
            fontSize: FontSizeManager.s20,
            color: AppColors.grey700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
