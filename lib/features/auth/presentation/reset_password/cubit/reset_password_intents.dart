sealed class ResetPasswordIntent {
  const ResetPasswordIntent();

  static const togglePasswordVisibility = TogglePasswordVisibilityIntent();
  static const toggleConfirmVisibility = ToggleConfirmVisibilityIntent();
}

class TogglePasswordVisibilityIntent extends ResetPasswordIntent {
  const TogglePasswordVisibilityIntent();
}

class ToggleConfirmVisibilityIntent extends ResetPasswordIntent {
  const ToggleConfirmVisibilityIntent();
}

class SubmitResetPasswordIntent extends ResetPasswordIntent {
  final String email;
  const SubmitResetPasswordIntent(this.email);
}
