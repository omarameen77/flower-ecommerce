sealed class ProfileEvent {
  const ProfileEvent();
}

final class ProfileOpened extends ProfileEvent {
  final String languageCode;

  ProfileOpened({required this.languageCode}) : super();
}

final class LoadProfile extends ProfileEvent {
  const LoadProfile() : super();
}

final class NotificationsChanged extends ProfileEvent {
  final bool enabled;

  NotificationsChanged(this.enabled) : super();
}

final class ToggleLanguage extends ProfileEvent {
  const ToggleLanguage() : super();
}

final class LogoutRequested extends ProfileEvent {
  const LogoutRequested() : super();
}
