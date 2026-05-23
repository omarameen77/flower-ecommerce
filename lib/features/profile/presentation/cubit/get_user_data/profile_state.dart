part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final BaseState<UserEntity> profileState;
  final BaseState<bool> logoutState;
  final bool notificationsEnabled;
  final String languageCode;

  const ProfileState({
    this.profileState = const BaseState(),
    this.logoutState = const BaseState(),
    this.notificationsEnabled = true,
    this.languageCode = 'en',
  });

  ProfileState copyWith({
    BaseState<UserEntity>? profileState,
    BaseState<bool>? logoutState,
    bool? notificationsEnabled,
    String? languageCode,
  }) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
      logoutState: logoutState ?? this.logoutState,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object?> get props => [
    profileState,
    logoutState,
    notificationsEnabled,
    languageCode,
  ];
}
