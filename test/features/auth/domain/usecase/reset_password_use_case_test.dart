import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/models/reset_password_entity.dart';
import 'package:flower/features/auth/domain/repos/auth_repo.dart';
import 'package:flower/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AuthRepo {}

void main() {
  late _MockRepo repo;
  late ResetPasswordUseCase useCase;

  setUp(() {
    repo = _MockRepo();
    useCase = ResetPasswordUseCase(repo);
  });

  test('forwards email and password to repo', () async {
    const entity = ResetPasswordEntity(message: 'ok', token: 't');
    when(
      () => repo.resetPassword(
        email: any(named: 'email'),
        newPassword: any(named: 'newPassword'),
      ),
    ).thenAnswer((_) async => SuccessBaseResponse(data: entity));

    final result = await useCase(email: 'a@b.com', newPassword: 'P@ss1234');

    expect(result, isA<SuccessBaseResponse<ResetPasswordEntity>>());
    verify(
      () => repo.resetPassword(email: 'a@b.com', newPassword: 'P@ss1234'),
    ).called(1);
  });
}
