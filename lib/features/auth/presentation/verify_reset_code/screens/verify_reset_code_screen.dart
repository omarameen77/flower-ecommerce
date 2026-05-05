import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/auth_header.dart';
import 'package:flower/core/widgets/custom_app_bar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/view_model/verify_reset_code_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/view_model/verify_reset_code_state.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/widgets/pin_error_row.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/widgets/pin_input.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/widgets/resend_code_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  const VerifyResetCodeScreen({super.key, required this.email});
  final String email;

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen> {
  bool _isResending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: context.password),
      body: BlocConsumer<VerifyResetCodeCubit, VerifyResetCodeState>(
        listener: (context, state) => _onStateChanged(context, state),
        builder: (context, state) => _buildBody(context, state),
      ),
    );
  }

  void _onStateChanged(BuildContext context, VerifyResetCodeState state) {
    if (state.data != null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.resetPassword,
        arguments: widget.email,
      );
    }
  }

  Future<void> _onResend() async {
    if (_isResending) return;
    setState(() => _isResending = true);
    final cubit = context.read<VerifyResetCodeCubit>();
    final response = await cubit.resend(email: widget.email);
    if (!mounted) return;
    setState(() => _isResending = false);
    _showResendSnackBar(response);
  }

  void _showResendSnackBar(BaseResponse response) {
    switch (response) {
      case SuccessBaseResponse():
        CustomSnackBar.success(context, context.codeSentAgain);
      case ErrorBaseResponse():
        CustomSnackBar.error(context, response.failure.message);
    }
  }

  Widget _buildBody(BuildContext context, VerifyResetCodeState state) {
    return Padding(
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
            PinInput(
              hasError: state.hasError,
              onCompleted: (pin) =>
                  context.read<VerifyResetCodeCubit>().verify(pin),
            ),
            if (state.hasError) ...[
              const AppSizedBox(height: AppSize.s8),
              PinErrorRow(message: state.errorMessage),
            ],
            const AppSizedBox(height: AppSize.s24),
            if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ResendCodeRow(
                onResend: _onResend,
                isLoading: _isResending,
              ),
          ],
        ),
      ),
    );
  }
}
