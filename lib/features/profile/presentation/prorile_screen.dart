import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/storage/secure_storage_service.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await SecureStorageService.deleteToken();

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Spacer(),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.error),
                  ),
                  onPressed: () {
                    _logout(context);
                  },
                  child: Text(
                    "Sign Out",
                    style: getMediumStyle(
                      context: context,
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
