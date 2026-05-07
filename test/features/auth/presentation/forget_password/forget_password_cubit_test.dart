import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_intents.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase])
void main() {
  late MockForgetPasswordUseCase useCase;

  setUpAll(() {
    provideDummy<BaseResponse<ForgetPasswordEntity>>(
      ErrorBaseResponse<ForgetPasswordEntity>(failure: Failure(message: '')),
    );
  });

  setUp(() => useCase = MockForgetPasswordUseCase());

  ForgetPasswordCubit buildCubit() {
    final cubit = ForgetPasswordCubit(useCase);
    cubit.emailController.text = 'a@b.com';
    return cubit;
  }

  test('emits [loading, success] when use case succeeds', () async {
    when(useCase(email: anyNamed('email'))).thenAnswer(
      (_) async => SuccessBaseResponse(
        data: const ForgetPasswordEntity(message: 'sent', info: 'check'),
      ),
    );
    final cubit = buildCubit();

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ForgetPasswordState>().having((s) => s.isLoading, 'loading', true),
        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.data, 'data', isNotNull),
      ]),
    );

    cubit.doIntent(ForgetPasswordIntent.submit);
    await expectation;
  });

  test('emits [loading, error] when use case fails', () async {
    when(useCase(email: anyNamed('email'))).thenAnswer(
      (_) async => ErrorBaseResponse(failure: Failure(message: 'oops')),
    );
    final cubit = buildCubit();

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ForgetPasswordState>().having((s) => s.isLoading, 'loading', true),
        isA<ForgetPasswordState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'oops',
        ),
      ]),
    );

    cubit.doIntent(ForgetPasswordIntent.submit);
    await expectation;
  });
}
