import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAuthTextField extends StatefulWidget {
  const CustomAuthTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.autofillHints,
    this.maxLines = 1,
  });

  final String label;
  final String? hint;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  final bool isPassword;

  final IconData? prefixIcon;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final bool enabled;

  final Iterable<String>? autofillHints;

  final int maxLines;

  @override
  State<CustomAuthTextField> createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: getMediumStyle(
            context: context,
            fontSize: FontSizeManager.s14,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 7),

        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword && _obscure,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          autofillHints: widget.autofillHints,
          maxLines: widget.isPassword ? 1 : widget.maxLines,

          style: getRegularStyle(
            context: context,
            color: AppColors.textPrimary,
            fontSize: FontSizeManager.s14,
          ),

          decoration: InputDecoration(
            hintText: widget.hint,

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
              vertical: 13,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.grey700.withOpacity(0.12),
                width: 1,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.grey700.withOpacity(0.12),
                width: 1,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.primary.withOpacity(0.55),
                width: 1.2,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.55),
                width: 1,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.65),
                width: 1.2,
              ),
            ),

            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: 19, color: AppColors.grey700)
                : null,

            suffixIcon: widget.isPassword
                ? _PasswordToggleButton(
                    isObscure: _obscure,
                    onToggle: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                : widget.suffixIcon,

            errorStyle: getRegularStyle(
              context: context,
              color: Colors.red,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordToggleButton extends StatelessWidget {
  const _PasswordToggleButton({
    required this.isObscure,
    required this.onToggle,
  });

  final bool isObscure;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      splashRadius: 20,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: Icon(
          isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          key: ValueKey(isObscure),
          size: 19,
          color: AppColors.grey700,
        ),
      ),
      tooltip: isObscure ? context.showPassword : context.hidePassword,
    );
  }
}
