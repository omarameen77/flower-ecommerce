import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/domain/models/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/repos/auth_repo.dart';
import 'package:flower/features/auth/domain/usecase/verify_reset_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AuthRepo {}

void main() {
  late _MockRepo repo;
  late VerifyResetCodeUseCase useCase;

  setUp(() {
    repo = _MockRepo();
    useCase = VerifyResetCodeUseCase(repo);
  });

  test('returns success when repo returns valid status', () async {
    const entity = VerifyResetCodeEntity(status: 'Success');
    when(
      () => repo.verifyResetCode(resetCode: '123456'),
    ).thenAnswer((_) async => SuccessBaseResponse(data: entity));

    final result = await useCase(resetCode: '123456');

    expect(result, isA<SuccessBaseResponse<VerifyResetCodeEntity>>());
    expect(entity.isValid, isTrue);
  });

  test('returns error when repo fails', () async {
    when(
      () => repo.verifyResetCode(resetCode: any(named: 'resetCode')),
    ).thenAnswer(
      (_) async => ErrorBaseResponse(failure: Failure(message: 'bad code')),
    );

    final result = await useCase(resetCode: '000000');

    expect(result, isA<ErrorBaseResponse<VerifyResetCodeEntity>>());
  });
}
