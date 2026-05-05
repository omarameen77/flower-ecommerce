import 'package:bloc_test/bloc_test.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/models/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flower/features/auth/domain/usecase/verify_reset_code_use_case.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/view_model/verify_reset_code_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/view_model/verify_reset_code_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockVerifyUseCase extends Mock implements VerifyResetCodeUseCase {}

class _MockForgetUseCase extends Mock implements ForgetPasswordUseCase {}

void main() {
  late _MockVerifyUseCase verifyUseCase;
  late _MockForgetUseCase forgetUseCase;

  setUp(() {
    verifyUseCase = _MockVerifyUseCase();
    forgetUseCase = _MockForgetUseCase();
  });

  VerifyResetCodeCubit buildCubit() =>
      VerifyResetCodeCubit(verifyUseCase, forgetUseCase);

  blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
    'emits success when code is valid',
    build: () {
      when(() => verifyUseCase(resetCode: any(named: 'resetCode'))).thenAnswer(
        (_) async => SuccessBaseResponse(
          data: const VerifyResetCodeEntity(status: 'Success'),
        ),
      );
      return buildCubit();
    },
    act: (cubit) => cubit.verify('123456'),
    expect: () => [
      isA<VerifyResetCodeState>().having((s) => s.isLoading, 'loading', true),
      isA<VerifyResetCodeState>().having((s) => s.data, 'data', isNotNull),
    ],
  );

  blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
    'emits hasError when status is not Success',
    build: () {
      when(() => verifyUseCase(resetCode: any(named: 'resetCode'))).thenAnswer(
        (_) async => SuccessBaseResponse(
          data: const VerifyResetCodeEntity(status: 'Fail'),
        ),
      );
      return buildCubit();
    },
    act: (cubit) => cubit.verify('000000'),
    expect: () => [
      isA<VerifyResetCodeState>().having((s) => s.isLoading, 'loading', true),
      isA<VerifyResetCodeState>().having((s) => s.hasError, 'hasError', true),
    ],
  );

  blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
    'emits hasError on failure',
    build: () {
      when(() => verifyUseCase(resetCode: any(named: 'resetCode'))).thenAnswer(
        (_) async => ErrorBaseResponse(failure: Failure(message: 'net')),
      );
      return buildCubit();
    },
    act: (cubit) => cubit.verify('000000'),
    expect: () => [
      isA<VerifyResetCodeState>().having((s) => s.isLoading, 'loading', true),
      isA<VerifyResetCodeState>()
          .having((s) => s.hasError, 'hasError', true)
          .having((s) => s.errorMessage, 'errorMessage', 'net'),
    ],
  );
}
