sealed class ForgetPasswordIntent {
  const ForgetPasswordIntent();
}

class SubmitForgetPasswordIntent extends ForgetPasswordIntent {
  final String email;

  const SubmitForgetPasswordIntent(this.email);
}

class VerifyResetCodeIntent extends ForgetPasswordIntent {
  final String resetCode;

  const VerifyResetCodeIntent(this.resetCode);
}
