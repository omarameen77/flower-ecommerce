import 'package:flower/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAvatarPlaceholder extends StatelessWidget {
  const ProfileAvatarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.grey200,
      child: Center(
        child: Icon(Icons.person, size: 40, color: Colors.black),
      ),
    );
  }
}
