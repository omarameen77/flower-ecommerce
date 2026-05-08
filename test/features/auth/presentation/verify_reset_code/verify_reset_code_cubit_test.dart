import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flower/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verify_reset_code_cubit_test.mocks.dart';

@GenerateMocks([VerifyResetCodeUseCase, ForgetPasswordUseCase])
void main() {
  late MockVerifyResetCodeUseCase verifyUseCase;
  late MockForgetPasswordUseCase forgetUseCase;
  late VerifyResetCodeCubit cubit;

  setUpAll(() {
    provideDummy<BaseResponse<VerifyResetCodeEntity>>(
      ErrorBaseResponse<VerifyResetCodeEntity>(failure: Failure(message: '')),
    );
    provideDummy<BaseResponse<ForgetPasswordEntity>>(
      ErrorBaseResponse<ForgetPasswordEntity>(failure: Failure(message: '')),
    );
  });

  setUp(() {
    verifyUseCase = MockVerifyResetCodeUseCase();
    forgetUseCase = MockForgetPasswordUseCase();
    cubit = VerifyResetCodeCubit(verifyUseCase, forgetUseCase);
  });

  test('emits success when code is valid', () async {
    when(verifyUseCase(resetCode: anyNamed('resetCode'))).thenAnswer(
      (_) async => SuccessBaseResponse(
        data: const VerifyResetCodeEntity(status: 'Success'),
      ),
    );

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<VerifyResetCodeState>().having(
          (s) => s.base.isLoading,
          'loading',
          true,
        ),
        isA<VerifyResetCodeState>().having(
          (s) => s.base.data,
          'data',
          isNotNull,
        ),
      ]),
    );

    cubit.doIntent(const VerifyIntent('1234'));
    await expectation;
  });

  test('emits hasError when status is not Success', () async {
    when(verifyUseCase(resetCode: anyNamed('resetCode'))).thenAnswer(
      (_) async => SuccessBaseResponse(
        data: const VerifyResetCodeEntity(status: 'Fail'),
      ),
    );

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<VerifyResetCodeState>().having(
          (s) => s.base.isLoading,
          'loading',
          true,
        ),
        isA<VerifyResetCodeState>().having((s) => s.hasError, 'hasError', true),
      ]),
    );

    cubit.doIntent(const VerifyIntent('0000'));
    await expectation;
  });

  test('emits hasError on failure with message', () async {
    when(verifyUseCase(resetCode: anyNamed('resetCode'))).thenAnswer(
      (_) async => ErrorBaseResponse(failure: Failure(message: 'net')),
    );

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<VerifyResetCodeState>().having(
          (s) => s.base.isLoading,
          'loading',
          true,
        ),
        isA<VerifyResetCodeState>()
            .having((s) => s.hasError, 'hasError', true)
            .having((s) => s.base.errorMessage, 'errorMessage', 'net'),
      ]),
    );

    cubit.doIntent(const VerifyIntent('0000'));
    await expectation;
  });
}
