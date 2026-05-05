import 'package:bloc_test/bloc_test.dart';
import 'package:flower/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:flower/features/auth/presentation/reset_password/view_model/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUseCase extends Mock implements ResetPasswordUseCase {}

void main() {
  late _MockUseCase useCase;

  setUp(() => useCase = _MockUseCase());

  blocTest<ResetPasswordCubit, ResetPasswordState>(
    'togglePasswordVisibility flips isObscurePassword',
    build: () => ResetPasswordCubit(useCase),
    act: (cubit) => cubit.togglePasswordVisibility(),
    expect: () => [
      isA<ResetPasswordState>().having(
        (s) => s.isObscurePassword,
        'isObscurePassword',
        false,
      ),
    ],
  );

  blocTest<ResetPasswordCubit, ResetPasswordState>(
    'toggleConfirmVisibility flips isObscureConfirm',
    build: () => ResetPasswordCubit(useCase),
    act: (cubit) => cubit.toggleConfirmVisibility(),
    expect: () => [
      isA<ResetPasswordState>().having(
        (s) => s.isObscureConfirm,
        'isObscureConfirm',
        false,
      ),
    ],
  );
}
