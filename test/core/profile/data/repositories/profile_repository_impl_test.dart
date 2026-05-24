import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/core/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flower/core/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  late ProfileRepositoryImpl profileRepositoryImpl;
  late MockProfileRemoteDataSource mockProfileRemoteDataSource;

  setUpAll(() {
    provideDummy<BaseResponse<UserDto>>(
      SuccessBaseResponse<UserDto>(data: UserDto(email: "test@example.com")),
    );
  });

  setUp(() {
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    profileRepositoryImpl = ProfileRepositoryImpl(mockProfileRemoteDataSource);
  });

  final tUserDto = UserDto(
    id: "1",
    email: "test@example.com",
    firstName: "Test",
    lastName: "User",
  );

  group('getProfile', () {
    test('should return SuccessBaseResponse<UserEntity> when remote data source is successful', () async {
      when(mockProfileRemoteDataSource.getProfile())
          .thenAnswer((_) async => SuccessBaseResponse<UserDto>(data: tUserDto));

      final result = await profileRepositoryImpl.getProfile();

      expect(result, isA<SuccessBaseResponse<UserEntity>>());
      final successResult = result as SuccessBaseResponse<UserEntity>;
      expect(successResult.data.email, tUserDto.email);
      verify(mockProfileRemoteDataSource.getProfile()).called(1);
      verifyNoMoreInteractions(mockProfileRemoteDataSource);
    });

    test('should return ErrorBaseResponse<UserEntity> when remote data source fails', () async {
      final tFailure = Failure(message: 'Remote Error');
      when(mockProfileRemoteDataSource.getProfile())
          .thenAnswer((_) async => ErrorBaseResponse<UserDto>(failure: tFailure));

      final result = await profileRepositoryImpl.getProfile();

      expect(result, isA<ErrorBaseResponse<UserEntity>>());
      final errorResult = result as ErrorBaseResponse<UserEntity>;
      expect(errorResult.failure, tFailure);
      verify(mockProfileRemoteDataSource.getProfile()).called(1);
      verifyNoMoreInteractions(mockProfileRemoteDataSource);
    });
  });
}
