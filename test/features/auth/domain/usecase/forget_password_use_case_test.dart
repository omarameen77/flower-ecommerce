import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower/features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo repo;
  late ForgetPasswordUseCase useCase;

  setUpAll(() {
    provideDummy<BaseResponse<ForgetPasswordEntity>>(
      ErrorBaseResponse<ForgetPasswordEntity>(failure: Failure(message: '')),
    );
    provideDummy<BaseResponse<VerifyResetCodeEntity>>(
      ErrorBaseResponse<VerifyResetCodeEntity>(failure: Failure(message: '')),
    );
    provideDummy<BaseResponse<ResetPasswordEntity>>(
      ErrorBaseResponse<ResetPasswordEntity>(failure: Failure(message: '')),
    );
  });

  setUp(() {
    repo = MockAuthRepo();
    useCase = ForgetPasswordUseCase(repo);
  });

  test('forwards email to repo and returns success entity', () async {
    const entity = ForgetPasswordEntity(message: 'sent', info: 'check email');
    when(
      repo.forgetPassword(email: anyNamed('email')),
    ).thenAnswer((_) async => SuccessBaseResponse(data: entity));

    final result = await useCase(email: 'a@b.com');

    expect(result, isA<SuccessBaseResponse<ForgetPasswordEntity>>());
    expect((result as SuccessBaseResponse<ForgetPasswordEntity>).data, entity);
    verify(repo.forgetPassword(email: 'a@b.com')).called(1);
  });

  test('propagates error from repo', () async {
    final failure = Failure(message: 'no internet');
    when(
      repo.forgetPassword(email: anyNamed('email')),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await useCase(email: 'a@b.com');

    expect(result, isA<ErrorBaseResponse<ForgetPasswordEntity>>());
    expect(
      (result as ErrorBaseResponse<ForgetPasswordEntity>).failure.message,
      'no internet',
    );
  });
}
