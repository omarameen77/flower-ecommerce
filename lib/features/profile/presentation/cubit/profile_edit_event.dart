import 'dart:io';

sealed class ProfileEditEvent {
  const ProfileEditEvent();
}

final class ProfileEditFirstNameChanged extends ProfileEditEvent {
  const ProfileEditFirstNameChanged(this.value);
  final String value;
}

final class ProfileEditLastNameChanged extends ProfileEditEvent {
  const ProfileEditLastNameChanged(this.value);
  final String value;
}

final class ProfileEditEmailChanged extends ProfileEditEvent {
  const ProfileEditEmailChanged(this.value);
  final String value;
}

final class ProfileEditPhoneChanged extends ProfileEditEvent {
  const ProfileEditPhoneChanged(this.value);
  final String value;
}

final class ProfileEditPhotoChanged extends ProfileEditEvent {
  const ProfileEditPhotoChanged(this.file);
  final File file;
}

final class ProfileEditSubmitted extends ProfileEditEvent {
  const ProfileEditSubmitted() : super();
}
