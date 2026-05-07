import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flower/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_intents.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'verify_reset_code_cubit_test.mocks.dart';

@GenerateMocks([VerifyResetCodeUseCase, ForgetPasswordUseCase])
void main() {
  late MockVerifyResetCodeUseCase verifyUseCase;
  late MockForgetPasswordUseCase forgetUseCase;

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
  });

  VerifyResetCodeCubit buildCubit() =>
      VerifyResetCodeCubit(verifyUseCase, forgetUseCase);

  test('emits success when code is valid', () async {
    when(verifyUseCase(resetCode: anyNamed('resetCode'))).thenAnswer(
      (_) async => SuccessBaseResponse(
        data: const VerifyResetCodeEntity(status: 'Success'),
      ),
    );
    final cubit = buildCubit();

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<VerifyResetCodeState>().having((s) => s.isLoading, 'loading', true),
        isA<VerifyResetCodeState>().having((s) => s.data, 'data', isNotNull),
      ]),
    );

    cubit.doIntent(const VerifyIntent('123456'));
    await expectation;
  });

  test('emits hasError when status is not Success', () async {
    when(verifyUseCase(resetCode: anyNamed('resetCode'))).thenAnswer(
      (_) async => SuccessBaseResponse(
        data: const VerifyResetCodeEntity(status: 'Fail'),
      ),
    );
    final cubit = buildCubit();

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<VerifyResetCodeState>().having((s) => s.isLoading, 'loading', true),
        isA<VerifyResetCodeState>().having((s) => s.hasError, 'hasError', true),
      ]),
    );

    cubit.doIntent(const VerifyIntent('000000'));
    await expectation;
  });

  test('emits hasError on failure', () async {
    when(verifyUseCase(resetCode: anyNamed('resetCode'))).thenAnswer(
      (_) async => ErrorBaseResponse(failure: Failure(message: 'net')),
    );
    final cubit = buildCubit();

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<VerifyResetCodeState>().having((s) => s.isLoading, 'loading', true),
        isA<VerifyResetCodeState>()
            .having((s) => s.hasError, 'hasError', true)
            .having((s) => s.errorMessage, 'errorMessage', 'net'),
      ]),
    );

    cubit.doIntent(const VerifyIntent('000000'));
    await expectation;
  });
}
