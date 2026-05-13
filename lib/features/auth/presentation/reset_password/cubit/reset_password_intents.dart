sealed class ResetPasswordIntent {
  const ResetPasswordIntent();
}

class SubmitResetPasswordIntent extends ResetPasswordIntent {
  final String email;
  final String newPassword;
  const SubmitResetPasswordIntent({
    required this.email,
    required this.newPassword,
  });
}
