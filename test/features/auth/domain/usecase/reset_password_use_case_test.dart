import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo repo;
  late ResetPasswordUseCase useCase;

  setUpAll(() {
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
    useCase = ResetPasswordUseCase(repo);
  });

  test('forwards email and password to repo on success', () async {
    const entity = ResetPasswordEntity(message: 'ok', token: 't');
    when(
      repo.resetPassword(
        email: anyNamed('email'),
        newPassword: anyNamed('newPassword'),
      ),
    ).thenAnswer((_) async => SuccessBaseResponse(data: entity));

    final result = await useCase(email: 'a@b.com', newPassword: 'P@ss1234');

    expect(result, isA<SuccessBaseResponse<ResetPasswordEntity>>());
    verify(
      repo.resetPassword(email: 'a@b.com', newPassword: 'P@ss1234'),
    ).called(1);
  });

  test('propagates error from repo', () async {
    final failure = Failure(message: 'boom');
    when(
      repo.resetPassword(
        email: anyNamed('email'),
        newPassword: anyNamed('newPassword'),
      ),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await useCase(email: 'a@b.com', newPassword: 'P@ss1234');

    expect(result, isA<ErrorBaseResponse<ResetPasswordEntity>>());
    expect(
      (result as ErrorBaseResponse<ResetPasswordEntity>).failure.message,
      'boom',
    );
  });
}
