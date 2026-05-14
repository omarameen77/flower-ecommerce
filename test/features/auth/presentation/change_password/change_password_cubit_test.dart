import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/entities/change_password_entity.dart';
import 'package:flower/features/auth/domain/use_cases/change_password_usecase.dart';
import 'package:flower/features/auth/presentation/change_password/cubit/change_password_cubit.dart';
import 'package:flower/features/auth/presentation/change_password/cubit/change_password_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_cubit_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  late MockChangePasswordUseCase useCase;
  late ChangePasswordCubit cubit;

  setUpAll(() {
    provideDummy<BaseResponse<ChangePasswordEntity>>(
      ErrorBaseResponse<ChangePasswordEntity>(failure: Failure(message: '')),
    );
  });

  setUp(() {
    useCase = MockChangePasswordUseCase();
    cubit = ChangePasswordCubit(useCase);
  });

  test('emits [loading, success] when submit succeeds', () async {
    when(
      useCase(
        oldPassword: anyNamed('oldPassword'),
        newPassword: anyNamed('newPassword'),
      ),
    ).thenAnswer(
      (_) async => SuccessBaseResponse(
        data: const ChangePasswordEntity(message: 'ok', token: 't'),
      ),
    );

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ChangePasswordState>().having(
          (s) => s.base.isLoading,
          'loading',
          true,
        ),
        isA<ChangePasswordState>()
            .having((s) => s.base.isLoading, 'loading', false)
            .having((s) => s.base.data, 'data', isNotNull),
      ]),
    );

    cubit.doIntent(
      const SubmitChangePasswordIntent(
        oldPassword: 'Old123!@',
        newPassword: 'New456!@',
      ),
    );
    await expectation;
  });

  test('emits [loading, error] when submit fails', () async {
    when(
      useCase(
        oldPassword: anyNamed('oldPassword'),
        newPassword: anyNamed('newPassword'),
      ),
    ).thenAnswer(
      (_) async =>
          ErrorBaseResponse(failure: Failure(message: 'wrong password')),
    );

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ChangePasswordState>().having(
          (s) => s.base.isLoading,
          'loading',
          true,
        ),
        isA<ChangePasswordState>().having(
          (s) => s.base.errorMessage,
          'errorMessage',
          'wrong password',
        ),
      ]),
    );

    cubit.doIntent(
      const SubmitChangePasswordIntent(
        oldPassword: 'Old123!@',
        newPassword: 'New456!@',
      ),
    );
    await expectation;
  });
}
