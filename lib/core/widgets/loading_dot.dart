import 'package:flower/core/resources/app_lotie.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDot extends StatelessWidget {
  const LoadingDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: Lottie.asset(AppLotie.loadingPink),
      ),
    );
  }
}
