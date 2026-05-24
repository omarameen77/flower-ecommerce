import 'package:flower/core/localization_constants/profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ProfileConstants.aboutUs)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text(
          ProfileConstants.aboutUsContent,
          style: getRegularStyle(
            context: context,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
