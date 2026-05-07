sealed class ForgetPasswordIntent {
  const ForgetPasswordIntent();

  static const submit = SubmitForgetPasswordIntent();
}

class SubmitForgetPasswordIntent extends ForgetPasswordIntent {
  const SubmitForgetPasswordIntent();
}
