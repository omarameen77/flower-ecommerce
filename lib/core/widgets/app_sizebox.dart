import 'package:flower/core/layout/responsive.dart';
import 'package:flutter/material.dart';

class AppSizedBox extends StatelessWidget {
  final double? height;
  final double? width;

  const AppSizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height != null ? Responsive.scale(context, height!) : null,
      width: width != null ? Responsive.scale(context, width!) : null,
    );
  }
}
