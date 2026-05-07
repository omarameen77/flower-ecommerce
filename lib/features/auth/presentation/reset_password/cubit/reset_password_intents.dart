sealed class ResetPasswordIntent {
  const ResetPasswordIntent();
}

class SubmitResetPasswordIntent extends ResetPasswordIntent {
  final String email;
  const SubmitResetPasswordIntent(this.email);
}
