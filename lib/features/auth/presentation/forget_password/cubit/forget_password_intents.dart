sealed class ForgetPasswordIntent {
  const ForgetPasswordIntent();
}

class SubmitForgetPasswordIntent extends ForgetPasswordIntent {
  final String email;
  const SubmitForgetPasswordIntent(this.email);
}
