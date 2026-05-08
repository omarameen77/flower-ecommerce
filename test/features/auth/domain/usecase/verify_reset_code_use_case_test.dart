import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower/features/auth/domain/use_cases/verify_reset_code_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verify_reset_code_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo repo;
  late VerifyResetCodeUseCase useCase;

  setUpAll(() {
    provideDummy<BaseResponse<VerifyResetCodeEntity>>(
      ErrorBaseResponse<VerifyResetCodeEntity>(failure: Failure(message: '')),
    );
    provideDummy<BaseResponse<ForgetPasswordEntity>>(
      ErrorBaseResponse<ForgetPasswordEntity>(failure: Failure(message: '')),
    );
    provideDummy<BaseResponse<ResetPasswordEntity>>(
      ErrorBaseResponse<ResetPasswordEntity>(failure: Failure(message: '')),
    );
  });

  setUp(() {
    repo = MockAuthRepo();
    useCase = VerifyResetCodeUseCase(repo);
  });

  test('returns success when repo returns valid status', () async {
    const entity = VerifyResetCodeEntity(status: 'Success');
    when(
      repo.verifyResetCode(resetCode: anyNamed('resetCode')),
    ).thenAnswer((_) async => SuccessBaseResponse(data: entity));

    final result = await useCase(resetCode: '1234');

    expect(result, isA<SuccessBaseResponse<VerifyResetCodeEntity>>());
    expect(entity.isValid, isTrue);
  });

  test('returns error with failure message when repo fails', () async {
    when(
      repo.verifyResetCode(resetCode: anyNamed('resetCode')),
    ).thenAnswer(
      (_) async => ErrorBaseResponse(failure: Failure(message: 'bad code')),
    );

    final result = await useCase(resetCode: '0000');

    expect(result, isA<ErrorBaseResponse<VerifyResetCodeEntity>>());
    expect(
      (result as ErrorBaseResponse<VerifyResetCodeEntity>).failure.message,
      'bad code',
    );
  });
}
