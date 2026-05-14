import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/change_password_entity.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower/features/auth/domain/use_cases/change_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo repo;
  late ChangePasswordUseCase useCase;

  setUpAll(() {
    provideDummy<BaseResponse<ChangePasswordEntity>>(
      ErrorBaseResponse<ChangePasswordEntity>(failure: Failure(message: '')),
    );
    provideDummy<BaseResponse<ResetPasswordEntity>>(
      ErrorBaseResponse<ResetPasswordEntity>(failure: Failure(message: '')),
    );
    provideDummy<BaseResponse<ForgetPasswordEntity>>(
      ErrorBaseResponse<ForgetPasswordEntity>(failure: Failure(message: '')),
    );
    provideDummy<BaseResponse<VerifyResetCodeEntity>>(
      ErrorBaseResponse<VerifyResetCodeEntity>(failure: Failure(message: '')),
    );
  });

  setUp(() {
    repo = MockAuthRepo();
    useCase = ChangePasswordUseCase(repo);
  });

  test('forwards old and new password to repo on success', () async {
    const entity = ChangePasswordEntity(message: 'ok', token: 't');
    when(
      repo.changePassword(
        oldPassword: anyNamed('oldPassword'),
        newPassword: anyNamed('newPassword'),
      ),
    ).thenAnswer((_) async => SuccessBaseResponse(data: entity));

    final result = await useCase(
      oldPassword: 'Old123!@',
      newPassword: 'New456!@',
    );

    expect(result, isA<SuccessBaseResponse<ChangePasswordEntity>>());
    verify(
      repo.changePassword(oldPassword: 'Old123!@', newPassword: 'New456!@'),
    ).called(1);
  });

  test('propagates error from repo', () async {
    final failure = Failure(message: 'wrong password');
    when(
      repo.changePassword(
        oldPassword: anyNamed('oldPassword'),
        newPassword: anyNamed('newPassword'),
      ),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await useCase(
      oldPassword: 'Old123!@',
      newPassword: 'New456!@',
    );

    expect(result, isA<ErrorBaseResponse<ChangePasswordEntity>>());
    expect(
      (result as ErrorBaseResponse<ChangePasswordEntity>).failure.message,
      'wrong password',
    );
  });
}
