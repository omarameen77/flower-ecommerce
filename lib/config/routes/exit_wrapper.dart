import 'package:flower/core/localization_constants/general_constants.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitWrapper extends StatefulWidget {
  final Widget child;

  const ExitWrapper({super.key, required this.child});

  @override
  State<ExitWrapper> createState() => _ExitWrapperState();
}

class _ExitWrapperState extends State<ExitWrapper> {
  DateTime? lastBackPress;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final now = DateTime.now();

        if (lastBackPress == null ||
            now.difference(lastBackPress!) > const Duration(seconds: 2)) {
          lastBackPress = now;

          CustomSnackBar.info(context, GeneralConstants.pressBackAgainToExit);
        } else {
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }
}
