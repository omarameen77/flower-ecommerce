import 'package:flower/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_intents.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'reset_password_cubit_test.mocks.dart';

@GenerateMocks([ResetPasswordUseCase])
void main() {
  late MockResetPasswordUseCase useCase;

  setUp(() => useCase = MockResetPasswordUseCase());

  test('togglePasswordVisibility flips isObscurePassword', () async {
    final cubit = ResetPasswordCubit(useCase);

    final expectation = expectLater(
      cubit.stream,
      emits(
        isA<ResetPasswordState>().having(
          (s) => s.isObscurePassword,
          'isObscurePassword',
          false,
        ),
      ),
    );

    cubit.doIntent(ResetPasswordIntent.togglePasswordVisibility);
    await expectation;
  });

  test('toggleConfirmVisibility flips isObscureConfirm', () async {
    final cubit = ResetPasswordCubit(useCase);

    final expectation = expectLater(
      cubit.stream,
      emits(
        isA<ResetPasswordState>().having(
          (s) => s.isObscureConfirm,
          'isObscureConfirm',
          false,
        ),
      ),
    );

    cubit.doIntent(ResetPasswordIntent.toggleConfirmVisibility);
    await expectation;
  });
}
