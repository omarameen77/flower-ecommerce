import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../layout/responsive.dart';
import 'app_colors.dart';

TextStyle _getTextStyle(
  BuildContext context,
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return GoogleFonts.inter(
    fontSize: Responsive.scale(context, fontSize),
    color: color,
    fontWeight: fontWeight,
  );
}

// Light
TextStyle getLightStyle({
  required BuildContext context,
  double fontSize = FontSizeManager.s12,
  required Color color,
}) {
  return _getTextStyle(context, fontSize, FontWeightManager.light, color);
}

// Regular
TextStyle getRegularStyle({
  required BuildContext context,
  double fontSize = FontSizeManager.s14,
  required Color color,
}) {
  return _getTextStyle(context, fontSize, FontWeightManager.regular, color);
}

// Medium
TextStyle getMediumStyle({
  required BuildContext context,
  double fontSize = FontSizeManager.s14,
  required Color color,
}) {
  return _getTextStyle(context, fontSize, FontWeightManager.medium, color);
}

// SemiBold
TextStyle getSemiBoldStyle({
  required BuildContext context,
  double fontSize = FontSizeManager.s16,
  required Color color,
}) {
  return _getTextStyle(context, fontSize, FontWeightManager.semiBold, color);
}

// Bold
TextStyle getBoldStyle({
  required BuildContext context,
  double fontSize = FontSizeManager.s18,
  required Color color,
}) {
  return _getTextStyle(context, fontSize, FontWeightManager.bold, color);
}

// Underlined text
TextStyle getTextWithLine(BuildContext context) {
  return TextStyle(
    color: AppColors.textPrimary,
    fontSize: Responsive.scale(context, FontSizeManager.s12),
    fontWeight: FontWeightManager.regular,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.textPrimary,
  );
}
