import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool isPassword;
  final TextInputType keyboardType;

  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.validator,
    this.controller,
    this.onChanged,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: autovalidateMode,
      obscureText: isPassword,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onChanged: onChanged,
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
    );
  }
}
