import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    this.hint = 'Search',
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.autofillHints,
    this.prefixIcon,
  });

  final String hint;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final bool enabled;

  final Iterable<String>? autofillHints;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled,
      autofillHints: autofillHints,

      style: getRegularStyle(
        context: context,
        color: AppColors.textPrimary,
        fontSize: FontSizeManager.s14,
      ),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: getRegularStyle(
          context: context,
          color: AppColors.grey700.withOpacity(0.65),
          fontSize: FontSizeManager.s14,
        ),

        isDense: true,

        filled: true,
        fillColor: AppColors.background.withOpacity(0.65),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),

        border: _border(color: AppColors.grey900, width: 1.2),

        enabledBorder: _border(
          color: AppColors.grey900.withOpacity(0.25),
          width: 1.2,
        ),

        focusedBorder: _border(
          color: AppColors.primary.withOpacity(0.70),
          width: 1.4,
        ),

        prefixIcon:
            prefixIcon ??
            Icon(Icons.search_rounded, size: 21, color: AppColors.grey700),

        errorStyle: getRegularStyle(
          context: context,
          color: Colors.red,
          fontSize: 11,
        ),
      ),
    );
  }

  OutlineInputBorder _border({required Color color, required double width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
