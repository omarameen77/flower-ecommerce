import 'package:flutter/material.dart';

class Responsive {
  static const double baseWidth = 375;

  static double scale(BuildContext context, double size) {
    final width = MediaQuery.of(context).size.width;
    return size * (width / baseWidth);
  }

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
