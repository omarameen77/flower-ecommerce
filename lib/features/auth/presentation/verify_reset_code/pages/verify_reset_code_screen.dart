import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/widgets/app_loading_widget.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/auth_header.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_intents.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/widgets/pin_error_row.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/widgets/pin_input.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/widgets/resend_code_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  const VerifyResetCodeScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.password),
      body: BlocListener<VerifyResetCodeCubit, VerifyResetCodeState>(
        listener: _onStateChanged,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppSizedBox(height: AppSize.s28),
                AuthHeader(
                  title: context.emailVerification,
                  subtitle: context.verificationCodeSubtitle,
                ),
                const AppSizedBox(height: AppSize.s28),
                _buildPinInput(),
                const AppSizedBox(height: AppSize.s24),
                _buildResendOrLoading(email),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput() {
    return BlocBuilder<VerifyResetCodeCubit, VerifyResetCodeState>(
      buildWhen: (p, c) => p.hasError != c.hasError,
      builder: (context, state) {
        return Column(
          children: [
            PinInput(
              hasError: state.hasError,
              onCompleted: (pin) => context
                  .read<VerifyResetCodeCubit>()
                  .doIntent(VerifyIntent(pin)),
            ),
            if (state.hasError) ...[
              const AppSizedBox(height: AppSize.s8),
              PinErrorRow(message: state.base.errorMessage?.tr()),
            ],
          ],
        );
      },
    );
  }

  Widget _buildResendOrLoading(String email) {
    return BlocBuilder<VerifyResetCodeCubit, VerifyResetCodeState>(
      buildWhen: (p, c) =>
          p.base.isLoading != c.base.isLoading ||
          p.isResending != c.isResending,
      builder: (context, state) {
        if (state.base.isLoading) return const AppLoadingWidget();
        return ResendCodeRow(
          onResend: () => context
              .read<VerifyResetCodeCubit>()
              .doIntent(ResendIntent(email)),
          isLoading: state.isResending,
        );
      },
    );
  }

  void _onStateChanged(BuildContext context, VerifyResetCodeState state) {
    if (state.base.data != null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.resetPassword,
        arguments: email,
      );
      return;
    }
    _handleResendStatus(context, state);
  }

  void _handleResendStatus(BuildContext context, VerifyResetCodeState state) {
    final cubit = context.read<VerifyResetCodeCubit>();
    if (state.resendSucceeded) {
      CustomSnackBar.success(context, context.codeSentAgain);
      cubit.doIntent(const ClearResendStatusIntent());
    } else if (state.resendErrorMessage != null) {
      CustomSnackBar.error(context, state.resendErrorMessage!.tr());
      cubit.doIntent(const ClearResendStatusIntent());
    }
  }
}
