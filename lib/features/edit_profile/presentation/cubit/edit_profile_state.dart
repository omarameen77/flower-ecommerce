part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? profilePhotoUrl;
  final File? photo;
  final BaseState<UserEntity> submitState;
  final BaseState<UserEntity> uploadPhotoState;

  const EditProfileState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.profilePhotoUrl,
    this.photo,
    this.submitState = const BaseState(),
    this.uploadPhotoState = const BaseState(),
  });

  EditProfileState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? profilePhotoUrl,
    File? photo,
    BaseState<UserEntity>? submitState,
    BaseState<UserEntity>? uploadPhotoState,
  }) {
    return EditProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      photo: photo ?? this.photo,
      submitState: submitState ?? this.submitState,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phone,
        profilePhotoUrl,
        photo,
        submitState,
        uploadPhotoState,
      ];
}


