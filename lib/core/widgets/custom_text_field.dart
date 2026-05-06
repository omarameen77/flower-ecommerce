import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      obscureText: widget.isPassword ? obscureText : false,

      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
