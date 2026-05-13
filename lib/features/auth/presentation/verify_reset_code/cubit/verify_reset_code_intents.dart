sealed class VerifyResetCodeIntent {
  const VerifyResetCodeIntent();

  static const clearResendStatus = ClearResendStatusIntent();
}

class VerifyIntent extends VerifyResetCodeIntent {
  final String code;
  const VerifyIntent(this.code);
}

class ResendIntent extends VerifyResetCodeIntent {
  final String email;
  const ResendIntent(this.email);
}

class ClearResendStatusIntent extends VerifyResetCodeIntent {
  const ClearResendStatusIntent();
}
