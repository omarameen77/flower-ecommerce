import 'package:bloc_test/bloc_test.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flower/features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUseCase extends Mock implements ForgetPasswordUseCase {}

void main() {
  late _MockUseCase useCase;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() => useCase = _MockUseCase());

  ForgetPasswordCubit buildCubit() {
    final cubit = ForgetPasswordCubit(useCase);
    cubit.emailController.text = 'a@b.com';
    return cubit;
  }

  blocTest<ForgetPasswordCubit, ForgetPasswordState>(
    'emits [loading, success] when use case succeeds',
    build: () {
      when(() => useCase(email: any(named: 'email'))).thenAnswer(
        (_) async => SuccessBaseResponse(
          data: const ForgetPasswordEntity(message: 'sent', info: 'check'),
        ),
      );
      return buildCubit();
    },
    act: (cubit) => cubit.submit(),
    expect: () => [
      isA<ForgetPasswordState>().having((s) => s.isLoading, 'loading', true),
      isA<ForgetPasswordState>()
          .having((s) => s.isLoading, 'loading', false)
          .having((s) => s.data, 'data', isNotNull),
    ],
  );

  blocTest<ForgetPasswordCubit, ForgetPasswordState>(
    'emits [loading, error] when use case fails',
    build: () {
      when(() => useCase(email: any(named: 'email'))).thenAnswer(
        (_) async => ErrorBaseResponse(failure: Failure(message: 'oops')),
      );
      return buildCubit();
    },
    act: (cubit) => cubit.submit(),
    expect: () => [
      isA<ForgetPasswordState>().having((s) => s.isLoading, 'loading', true),
      isA<ForgetPasswordState>().having(
        (s) => s.errorMessage,
        'errorMessage',
        'oops',
      ),
    ],
  );
}
