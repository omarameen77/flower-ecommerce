import 'package:dio/dio.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/profile_response/profile_response.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/core/profile/api/api_client/profile_api_client.dart';
import 'package:flower/core/profile/api/datasource/profile_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProfileApiClient])
void main() {
  late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;
  late MockProfileApiClient mockProfileApiClient;

  setUp(() {
    mockProfileApiClient = MockProfileApiClient();
    profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(mockProfileApiClient);
  });

  final tUserDto = UserDto(
    id: "1",
    email: "test@example.com",
    firstName: "Test",
    lastName: "User",
  );

  group('getProfile', () {
    test('should return SuccessBaseResponse when api client returns user', () async {
      final tResponse = ProfileResponseDto(message: "success", user: tUserDto);
      
      when(mockProfileApiClient.getProfile())
          .thenAnswer((_) async => tResponse);

      final result = await profileRemoteDataSourceImpl.getProfile();

      expect(result, isA<SuccessBaseResponse<UserDto>>());
      final successResult = result as SuccessBaseResponse<UserDto>;
      expect(successResult.data, tUserDto);
      verify(mockProfileApiClient.getProfile()).called(1);
      verifyNoMoreInteractions(mockProfileApiClient);
    });

    test('should return ErrorBaseResponse when api client returns response without user', () async {
      final tResponse = ProfileResponseDto(message: "success", user: null);
      
      when(mockProfileApiClient.getProfile())
          .thenAnswer((_) async => tResponse);

      final result = await profileRemoteDataSourceImpl.getProfile();

      expect(result, isA<ErrorBaseResponse<UserDto>>());
      final errorResult = result as ErrorBaseResponse<UserDto>;
      expect(errorResult.failure.message, "error_massages.unknownError");
      verify(mockProfileApiClient.getProfile()).called(1);
      verifyNoMoreInteractions(mockProfileApiClient);
    });

    test('should return ErrorBaseResponse when api client throws an exception', () async {
      final tException = Exception('Network error');
      
      when(mockProfileApiClient.getProfile())
          .thenThrow(tException);

      final result = await profileRemoteDataSourceImpl.getProfile();

      expect(result, isA<ErrorBaseResponse<UserDto>>());
      verify(mockProfileApiClient.getProfile()).called(1);
      verifyNoMoreInteractions(mockProfileApiClient);
    });
  });
}
