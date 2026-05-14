/*
UNIT TESTING STEPS IN THE MAIN FUNCTION
1. ARRANGE
    1. Create and get all dependencies and variables needed for the test
2. ACT
3. ASSERT

GET PROFILE (ProfileRepositoryImpl)

Use cases:
1. success  return => SuccessBaseResponse<UserEntity>(data from UserDto.toDomain())
2. error    return => ErrorBaseResponse<UserEntity>(failure from remote)
3. success with sparse DTO (empty strings from API) => still SuccessBaseResponse<UserEntity>

Dependencies:
1. ProfileRemoteDataSource (mock)
*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/core/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flower/core/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  // ARRANGE (shared)
  late MockProfileRemoteDataSource mockProfileRemoteDataSource;
  late ProfileRepositoryImpl profileRepositoryImpl;

  late UserDto userDto;

  setUpAll(() {
    // provide dummy data for Mockito when returning BaseResponse<T>
    provideDummy<BaseResponse<UserDto>>(
      SuccessBaseResponse<UserDto>(
        data: UserDto(email: 'test@example.com', id: '1'),
      ),
    );
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(
        data: UserEntity(email: 'test@example.com'),
      ),
    );
  });

  setUp(() {
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    profileRepositoryImpl = ProfileRepositoryImpl(mockProfileRemoteDataSource);

    userDto = UserDto(
      id: 'user-1',
      firstName: 'ziad',
      lastName: 'sleem',
      email: 'ziad_sleem@gmail.com',
      phone: '+201000000000',
      gender: 'male',
      photo: 'https://example.com/photo.jpg',
      role: 'user',
    );
  });

  group('profile repository impl', () {
    group('getProfile', () {
      test(
        'Return SuccessBaseResponse<UserEntity> when getProfile is successful',
        () async {
          // ARRANGE
          when(mockProfileRemoteDataSource.getProfile()).thenAnswer(
            (_) async => SuccessBaseResponse<UserDto>(data: userDto),
          );

          // ACT
          final result = await profileRepositoryImpl.getProfile();

          // ASSERT
          expect(result, isA<SuccessBaseResponse<UserEntity>>());
          final success = result as SuccessBaseResponse<UserEntity>;
          expect(success.data.email, userDto.email);
          expect(success.data.firstName, userDto.firstName);
          expect(success.data.lastName, userDto.lastName);
          verify(mockProfileRemoteDataSource.getProfile()).called(1);
        },
      );

      test(
        'Return SuccessBaseResponse<UserEntity> when DTO has empty string fields',
        () async {
          // ARRANGE
          final sparseDto = UserDto(
            firstName: '',
            lastName: '',
            email: '',
          );
          when(mockProfileRemoteDataSource.getProfile()).thenAnswer(
            (_) async => SuccessBaseResponse<UserDto>(data: sparseDto),
          );

          // ACT
          final result = await profileRepositoryImpl.getProfile();

          // ASSERT
          expect(result, isA<SuccessBaseResponse<UserEntity>>());
          final success = result as SuccessBaseResponse<UserEntity>;
          expect(success.data.email, '');
          expect(success.data.firstName, '');
          expect(success.data.lastName, '');
          verify(mockProfileRemoteDataSource.getProfile()).called(1);
        },
      );

      test('Return ErrorBaseResponse<UserEntity> when getProfile fails', () async {
        // ARRANGE
        final failure = Failure(message: 'Server error');
        when(mockProfileRemoteDataSource.getProfile()).thenAnswer(
          (_) async => ErrorBaseResponse<UserDto>(failure: failure),
        );

        // ACT
        final result = await profileRepositoryImpl.getProfile();

        // ASSERT
        expect(result, isA<ErrorBaseResponse<UserEntity>>());
        final error = result as ErrorBaseResponse<UserEntity>;
        expect(error.failure.message, failure.message);
        verify(mockProfileRemoteDataSource.getProfile()).called(1);
      });
    });
  });
}
