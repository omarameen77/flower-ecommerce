import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/data/data_sources/auth_remote_ds.dart';
import 'package:flower/features/auth/data/models/response/forget_password_response.dart';
import 'package:flower/features/auth/data/repos/auth_repo_impl.dart';
import 'package:flower/features/auth/domain/models/forget_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDs extends Mock implements AuthRemoteDs {}

void main() {
  late _MockDs ds;
  late AuthRepoImpl repo;

  setUp(() {
    ds = _MockDs();
    repo = AuthRepoImpl(ds);
  });

  test('maps DTO to entity on success', () async {
    final dto = ForgetPasswordResponseDto(message: 'sent', info: 'check');
    when(
      () => ds.forgetPassword(email: 'a@b.com'),
    ).thenAnswer((_) async => SuccessBaseResponse(data: dto));

    final result = await repo.forgetPassword(email: 'a@b.com');

    expect(result, isA<SuccessBaseResponse<ForgetPasswordEntity>>());
    final entity = (result as SuccessBaseResponse<ForgetPasswordEntity>).data;
    expect(entity.message, 'sent');
    expect(entity.info, 'check');
  });

  test('preserves failure on error', () async {
    final failure = Failure(message: 'boom');
    when(
      () => ds.forgetPassword(email: any(named: 'email')),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await repo.forgetPassword(email: 'a@b.com');

    expect(result, isA<ErrorBaseResponse<ForgetPasswordEntity>>());
    expect(
      (result as ErrorBaseResponse<ForgetPasswordEntity>).failure,
      failure,
    );
  });
}
