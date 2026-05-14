/*
UNIT TESTING STEPS
1. ARRANGE — dependencies, inputs, mocks
2. ACT — call the method under test
3. ASSERT — verify type, data, and interactions

EditProfileRemoteDataSourceImpl — editProfile()

Cases:
1. API returns ProfileResponseDto with user => SuccessBaseResponse<UserDto>
2. API returns user null => ErrorBaseResponse<UserDto>
3. API throws => ErrorBaseResponse<UserDto>

Dependency: EditProfileApiClient (mock)
*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/profile_response/profile_response.dart';
import 'package:flower/core/network/model/user_models/user.dart';
import 'package:flower/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:flower/features/edit_profile/api/datasource/edit_profile_remote_data_source_impl.dart';
import 'package:flower/features/edit_profile/data/models/edit_profile_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([EditProfileApiClient])
void main() {
  late MockEditProfileApiClient mockApiClient;
  late EditProfileRemoteDataSourceImpl dataSource;

  late UserDto userDto;
  late EditProfileRequestDto request;

  setUpAll(() {
    provideDummy<ProfileResponseDto>(
      ProfileResponseDto(user: UserDto(email: 'e@test.com', id: '1')),
    );
  });

  setUp(() {
    mockApiClient = MockEditProfileApiClient();
    dataSource = EditProfileRemoteDataSourceImpl(mockApiClient);

    userDto = UserDto(
      id: '1',
      firstName: 'Nour',
      lastName: 'Mohamed',
      email: 'nour@test.com',
    );
    request = const EditProfileRequestDto(
      firstName: 'Nour',
      lastName: 'Mohamed',
      email: 'nour@test.com',
      phone: '+201000000000',
    );
  });

  group('edit profile remote data source impl', () {
    group('editProfile', () {
      test(
        'Return SuccessBaseResponse<UserDto> when API returns user',
        () async {
          when(mockApiClient.editProfile(request)).thenAnswer(
            (_) async => ProfileResponseDto(message: 'ok', user: userDto),
          );

          final result = await dataSource.editProfile(request);

          expect(result, isA<SuccessBaseResponse<UserDto>>());
          final success = result as SuccessBaseResponse<UserDto>;
          expect(success.data.email, userDto.email);
          expect(success.data.firstName, userDto.firstName);
          verify(mockApiClient.editProfile(request)).called(1);
        },
      );

      test(
        'Return ErrorBaseResponse<UserDto> when API returns null user',
        () async {
          when(mockApiClient.editProfile(request)).thenAnswer(
            (_) async => ProfileResponseDto(message: 'missing', user: null),
          );

          final result = await dataSource.editProfile(request);

          expect(result, isA<ErrorBaseResponse<UserDto>>());
          verify(mockApiClient.editProfile(request)).called(1);
        },
      );

      test(
        'Return ErrorBaseResponse<UserDto> when API throws',
        () async {
          when(mockApiClient.editProfile(request)).thenThrow(
            Exception('network'),
          );

          final result = await dataSource.editProfile(request);

          expect(result, isA<ErrorBaseResponse<UserDto>>());
          verify(mockApiClient.editProfile(request)).called(1);
        },
      );
    });
  });
}
