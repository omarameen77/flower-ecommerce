sealed class ChangePasswordIntent {
  const ChangePasswordIntent();
}

class SubmitChangePasswordIntent extends ChangePasswordIntent {
  final String oldPassword;
  final String newPassword;

  const SubmitChangePasswordIntent({
    required this.oldPassword,
    required this.newPassword,
  });
}
