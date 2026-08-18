import 'package:flower/core/resources/app_lotie.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/login/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswordOtpStep extends StatefulWidget {
  const ForgetPasswordOtpStep({
    super.key,
    required this.controller,
    required this.onSubmit,
    this.isVerifyingCode = false,
    this.isCodeValid,
    this.errorMessage,
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;

  final bool isVerifyingCode;
  final bool? isCodeValid;
  final String? errorMessage;

  @override
  State<ForgetPasswordOtpStep> createState() => _ForgetPasswordOtpStepState();
}

class _ForgetPasswordOtpStepState extends State<ForgetPasswordOtpStep> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onCodeChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCodeChanged);
    super.dispose();
  }

  void _onCodeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isComplete = widget.controller.text.length == 6;

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 54,
      textStyle: getSemiBoldStyle(
        context: context,
        fontSize: FontSizeManager.s18,
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey700.withOpacity(0.12)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      textStyle: getSemiBoldStyle(
        context: context,
        fontSize: FontSizeManager.s18,
        color: AppColors.primary,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.65),
          width: 1.5,
        ),
      ),
    );

    final successPinTheme = defaultPinTheme.copyWith(
      textStyle: getSemiBoldStyle(
        context: context,
        fontSize: FontSizeManager.s18,
        color: Colors.green,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.withOpacity(0.75), width: 1.5),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      textStyle: getSemiBoldStyle(
        context: context,
        fontSize: FontSizeManager.s18,
        color: AppColors.error,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.error.withOpacity(0.75),
          width: 1.5,
        ),
      ),
    );
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const AuthHeader(
            title: 'Email Verification',
            subtitle: 'Enter the code sent to your email',
          ),
          const AppSizedBox(height: 35),
          SizedBox(
            height: 200,
            width: 200,
            child: Lottie.asset(
              AppLotie.lottieOtp,
              repeat: false,
              fit: BoxFit.contain,
            ),
          ),
          const AppSizedBox(height: 30),
          Pinput(
            controller: widget.controller,
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: widget.isCodeValid == true
                ? successPinTheme
                : defaultPinTheme,
            errorPinTheme: errorPinTheme,
            followingPinTheme: widget.isCodeValid == true
                ? successPinTheme
                : widget.isCodeValid == false
                ? errorPinTheme
                : defaultPinTheme,
            keyboardType: TextInputType.number,
            forceErrorState: widget.isCodeValid == false,
            enabled: !widget.isVerifyingCode,
            onCompleted: (_) {},
          ),

          // Error message
          if (widget.isCodeValid == false && widget.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.errorMessage!,
                  style: getRegularStyle(
                    context: context,
                    fontSize: FontSizeManager.s12,
                    color: AppColors.error,
                  ),
                ),
              ),
            ),

          // Success message
          if (widget.isCodeValid == true)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Code verified successfully',
                style: getSemiBoldStyle(
                  context: context,
                  fontSize: FontSizeManager.s12,
                  color: Colors.green,
                ),
              ),
            ),

          const AppSizedBox(height: 20),

          TextButton(
            onPressed: widget.isVerifyingCode
                ? null
                : () {
                    widget.controller.clear();
                  },
            child: Text(
              'Resend Code',
              style:
                  getSemiBoldStyle(
                    context: context,
                    fontSize: FontSizeManager.s14,
                    color: AppColors.primary,
                  ).copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
            ),
          ),

          const AppSizedBox(height: 8),

          // Verify Button
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              text: widget.isVerifyingCode ? 'Verifying...' : 'Verify Code',
              onTap: !isComplete || widget.isVerifyingCode
                  ? null
                  : widget.onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
