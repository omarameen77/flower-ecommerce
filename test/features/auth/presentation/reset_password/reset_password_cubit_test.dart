import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_cubit_test.mocks.dart';

@GenerateMocks([ResetPasswordUseCase])
void main() {
  late MockResetPasswordUseCase useCase;

  setUpAll(() {
    provideDummy<BaseResponse<ResetPasswordEntity>>(
      ErrorBaseResponse<ResetPasswordEntity>(failure: Failure(message: '')),
    );
  });

  setUp(() => useCase = MockResetPasswordUseCase());

  test('emits [loading, success] when submit succeeds', () async {
    when(
      useCase(
        email: anyNamed('email'),
        newPassword: anyNamed('newPassword'),
      ),
    ).thenAnswer(
      (_) async => SuccessBaseResponse(
        data: const ResetPasswordEntity(message: 'ok', token: 't'),
      ),
    );
    final cubit = ResetPasswordCubit(useCase);
    cubit.passwordController.text = 'P@ssw0rd!';

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ResetPasswordState>().having((s) => s.isLoading, 'loading', true),
        isA<ResetPasswordState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.data, 'data', isNotNull),
      ]),
    );

    cubit.doIntent(const SubmitResetPasswordIntent('a@b.com'));
    await expectation;
  });

  test('emits [loading, error] when submit fails', () async {
    when(
      useCase(
        email: anyNamed('email'),
        newPassword: anyNamed('newPassword'),
      ),
    ).thenAnswer(
      (_) async => ErrorBaseResponse(failure: Failure(message: 'boom')),
    );
    final cubit = ResetPasswordCubit(useCase);
    cubit.passwordController.text = 'P@ssw0rd!';

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ResetPasswordState>().having((s) => s.isLoading, 'loading', true),
        isA<ResetPasswordState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'boom',
        ),
      ]),
    );

    cubit.doIntent(const SubmitResetPasswordIntent('a@b.com'));
    await expectation;
  });
}
