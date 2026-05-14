sealed class EditProfileEvent {
  const EditProfileEvent();
}

final class EditProfileFirstNameChanged extends EditProfileEvent {
  const EditProfileFirstNameChanged(this.value);
  final String value;
}

final class EditProfileLastNameChanged extends EditProfileEvent {
  const EditProfileLastNameChanged(this.value);
  final String value;
}

final class EditProfileEmailChanged extends EditProfileEvent {
  const EditProfileEmailChanged(this.value);
  final String value;
}

final class EditProfilePhoneChanged extends EditProfileEvent {
  const EditProfilePhoneChanged(this.value);
  final String value;
}

final class EditProfileSubmitted extends EditProfileEvent {
  const EditProfileSubmitted() : super();
}
