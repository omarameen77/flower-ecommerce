/*
UNIT TESTING STEPS
1. ARRANGE — dependencies, inputs, mocks
2. ACT — call the method under test
3. ASSERT — verify type, data, and interactions

ProfileRemoteDataSourceImpl — getProfile()

Cases:
1. API returns ProfileResponseDto with user => SuccessBaseResponse<UserDto>
2. API returns user null => ErrorBaseResponse<UserDto>
3. API throws => ErrorBaseResponse<UserDto>

Dependency: ProfileApiClient (mock)
*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/profile_response/profile_response.dart';
import 'package:flower/core/network/model/user_models/user.dart';
import 'package:flower/core/profile/api/api_client/profile_api_client.dart';
import 'package:flower/core/profile/api/datasource/profile_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProfileApiClient])
void main() {
  late MockProfileApiClient mockProfileApiClient;
  late ProfileRemoteDataSourceImpl dataSource;

  late UserDto userDto;

  setUpAll(() {
    provideDummy<ProfileResponseDto>(
      ProfileResponseDto(user: UserDto(email: 'e@test.com', id: '1')),
    );
  });

  setUp(() {
    mockProfileApiClient = MockProfileApiClient();
    dataSource = ProfileRemoteDataSourceImpl(mockProfileApiClient);

    userDto = UserDto(
      id: '1',
      firstName: 'Nour',
      lastName: 'Mohamed',
      email: 'nour@test.com',
    );
  });

  group('profile remote data source impl', () {
    group('getProfile', () {
      test(
        'Return SuccessBaseResponse<UserDto> when API returns user',
        () async {
          // ARRANGE
          when(mockProfileApiClient.getProfile()).thenAnswer(
            (_) async => ProfileResponseDto(message: 'ok', user: userDto),
          );

          // ACT
          final result = await dataSource.getProfile();

          // ASSERT
          expect(result, isA<SuccessBaseResponse<UserDto>>());
          final success = result as SuccessBaseResponse<UserDto>;
          expect(success.data.email, userDto.email);
          expect(success.data.firstName, userDto.firstName);
          verify(mockProfileApiClient.getProfile()).called(1);
        },
      );

      test(
        'Return ErrorBaseResponse<UserDto> when API returns null user',
        () async {
          // ARRANGE
          when(mockProfileApiClient.getProfile()).thenAnswer(
            (_) async => ProfileResponseDto(message: 'missing', user: null),
          );

          // ACT
          final result = await dataSource.getProfile();

          // ASSERT
          expect(result, isA<ErrorBaseResponse<UserDto>>());
          verify(mockProfileApiClient.getProfile()).called(1);
        },
      );

      test(
        'Return ErrorBaseResponse<UserDto> when API throws',
        () async {
          // ARRANGE
          when(mockProfileApiClient.getProfile()).thenThrow(Exception('network'));

          // ACT
          final result = await dataSource.getProfile();

          // ASSERT
          expect(result, isA<ErrorBaseResponse<UserDto>>());
          verify(mockProfileApiClient.getProfile()).called(1);
        },
      );
    });
  });
}
