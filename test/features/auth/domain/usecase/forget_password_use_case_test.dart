import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower/features/auth/domain/repos/auth_repo.dart';
import 'package:flower/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AuthRepo {}

void main() {
  late _MockRepo repo;
  late ForgetPasswordUseCase useCase;

  setUp(() {
    repo = _MockRepo();
    useCase = ForgetPasswordUseCase(repo);
  });

  test('forwards email to repo and returns success entity', () async {
    const entity = ForgetPasswordEntity(message: 'sent', info: 'check email');
    when(
      () => repo.forgetPassword(email: 'a@b.com'),
    ).thenAnswer((_) async => SuccessBaseResponse(data: entity));

    final result = await useCase(email: 'a@b.com');

    expect(result, isA<SuccessBaseResponse<ForgetPasswordEntity>>());
    expect((result as SuccessBaseResponse<ForgetPasswordEntity>).data, entity);
    verify(() => repo.forgetPassword(email: 'a@b.com')).called(1);
  });

  test('propagates error from repo', () async {
    final failure = Failure(message: 'no internet');
    when(
      () => repo.forgetPassword(email: any(named: 'email')),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await useCase(email: 'a@b.com');

    expect(result, isA<ErrorBaseResponse<ForgetPasswordEntity>>());
    expect(
      (result as ErrorBaseResponse<ForgetPasswordEntity>).failure.message,
      'no internet',
    );
  });
}
