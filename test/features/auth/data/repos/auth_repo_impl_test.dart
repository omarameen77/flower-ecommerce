import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flower/features/auth/data/models/response/forget_password_response.dart';
import 'package:flower/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDs])
void main() {
  late MockAuthRemoteDs ds;
  late AuthRepoImpl repo;

  setUpAll(() {
    provideDummy<BaseResponse<ForgetPasswordResponseDto>>(
      ErrorBaseResponse<ForgetPasswordResponseDto>(
        failure: Failure(message: ''),
      ),
    );
    provideDummy<BaseResponse<VerifyResetCodeResponseDto>>(
      ErrorBaseResponse<VerifyResetCodeResponseDto>(
        failure: Failure(message: ''),
      ),
    );
    provideDummy<BaseResponse<ResetPasswordResponseDto>>(
      ErrorBaseResponse<ResetPasswordResponseDto>(
        failure: Failure(message: ''),
      ),
    );
  });

  setUp(() {
    ds = MockAuthRemoteDs();
    repo = AuthRepoImpl(ds);
  });

  test('maps DTO to entity on success', () async {
    final dto = ForgetPasswordResponseDto(message: 'sent', info: 'check');
    when(
      ds.forgetPassword(email: anyNamed('email')),
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
      ds.forgetPassword(email: anyNamed('email')),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await repo.forgetPassword(email: 'a@b.com');

    expect(result, isA<ErrorBaseResponse<ForgetPasswordEntity>>());
    expect(
      (result as ErrorBaseResponse<ForgetPasswordEntity>).failure,
      failure,
    );
  });
}
