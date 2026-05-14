import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/core/profile/domain/usecases/get_profile_use_case.dart';
import 'package:flower/core/storage/secure_storage_service.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileCubit(this._getProfileUseCase) : super(const ProfileState());

  void doEvent(ProfileEvent event) {
    switch (event) {
      case ProfileOpened():
        emit(state.copyWith(languageCode: event.languageCode));
        _loadProfile();
        break;
      case LoadProfile():
        _loadProfile();
        break;
      case NotificationsChanged():
        emit(state.copyWith(notificationsEnabled: event.enabled));
        break;
      case ToggleLanguage():
        final next = state.languageCode == 'en' ? 'ar' : 'en';
        emit(state.copyWith(languageCode: next));
        break;
      case LogoutRequested():
        _logout();
        break;
    }
  }

  Future<void> _loadProfile() async {
    try {
      emit(state.copyWith(profileState: const BaseState(isLoading: true)));

      final result = await _getProfileUseCase.call();

      if (result is SuccessBaseResponse<UserEntity>) {
        emit(
          state.copyWith(
            profileState: BaseState(isLoading: false, data: result.data),
          ),
        );
      } else if (result is ErrorBaseResponse<UserEntity>) {
        emit(
          state.copyWith(
            profileState: BaseState(
              isLoading: false,
              errorMessage: result.failure.message,
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          profileState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }

  Future<void> _logout() async {
    try {
      emit(state.copyWith(logoutState: const BaseState(isLoading: true)));

      await SecureStorageService.deleteToken();

      emit(
        state.copyWith(
          logoutState: const BaseState(isLoading: false, data: true),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          logoutState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }
}
