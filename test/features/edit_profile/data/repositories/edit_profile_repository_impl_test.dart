/*
UNIT TESTING STEPS
1. ARRANGE
2. ACT
3. ASSERT

EDIT PROFILE (EditProfileRepositoryImpl)

Cases:
1. success return => SuccessBaseResponse<UserEntity>(data from UserDto.toDomain())
2. error return => ErrorBaseResponse<UserEntity>(failure from remote)
3. passes trimmed firstName, lastName, email, phone to remote as EditProfileRequestDto

Dependency: EditProfileRemoteDataSource (mock)
*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:flower/features/edit_profile/data/models/edit_profile_request.dart';
import 'package:flower/features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_repository_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSource])
void main() {
  late MockEditProfileRemoteDataSource mockRemoteDataSource;
  late EditProfileRepositoryImpl repository;

  late UserDto userDto;

  setUpAll(() {
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
    mockRemoteDataSource = MockEditProfileRemoteDataSource();
    repository = EditProfileRepositoryImpl(mockRemoteDataSource);

    userDto = UserDto(
      id: 'user-1',
      firstName: 'ziad',
      lastName: 'sleem',
      email: 'ziad_sleem@gmail.com',
      phone: '+201000000000',
      role: 'user',
    );
  });

  group('edit profile repository impl', () {
    group('editProfile', () {
      test(
        'Return SuccessBaseResponse<UserEntity> when remote succeeds',
        () async {
          when(mockRemoteDataSource.editProfile(any)).thenAnswer(
            (_) async => SuccessBaseResponse<UserDto>(data: userDto),
          );

          final result = await repository.editProfile(
            firstName: userDto.firstName!,
            lastName: userDto.lastName!,
            email: userDto.email!,
            phone: userDto.phone!,
          );

          expect(result, isA<SuccessBaseResponse<UserEntity>>());
          final success = result as SuccessBaseResponse<UserEntity>;
          expect(success.data.email, userDto.email);
          expect(success.data.firstName, userDto.firstName);
          expect(success.data.lastName, userDto.lastName);
          verify(mockRemoteDataSource.editProfile(any)).called(1);
        },
      );

      test(
        'Return SuccessBaseResponse<UserEntity> when DTO has empty string fields',
        () async {
          final sparseDto = UserDto(
            firstName: '',
            lastName: '',
            email: '',
            phone: '',
          );
          when(mockRemoteDataSource.editProfile(any)).thenAnswer(
            (_) async => SuccessBaseResponse<UserDto>(data: sparseDto),
          );

          final result = await repository.editProfile(
            firstName: '',
            lastName: '',
            email: '',
            phone: '',
          );

          expect(result, isA<SuccessBaseResponse<UserEntity>>());
          final success = result as SuccessBaseResponse<UserEntity>;
          expect(success.data.email, '');
          expect(success.data.firstName, '');
          verify(mockRemoteDataSource.editProfile(any)).called(1);
        },
      );

      test('Return ErrorBaseResponse<UserEntity> when remote fails', () async {
        final failure = Failure(message: 'Server error');
        when(mockRemoteDataSource.editProfile(any)).thenAnswer(
          (_) async => ErrorBaseResponse<UserDto>(failure: failure),
        );

        final result = await repository.editProfile(
          firstName: 'a',
          lastName: 'b',
          email: 'a@b.com',
          phone: '+1',
        );

        expect(result, isA<ErrorBaseResponse<UserEntity>>());
        final error = result as ErrorBaseResponse<UserEntity>;
        expect(error.failure.message, failure.message);
        verify(mockRemoteDataSource.editProfile(any)).called(1);
      });

      test('Sends trimmed fields in EditProfileRequestDto', () async {
        when(mockRemoteDataSource.editProfile(any)).thenAnswer(
          (invocation) async {
            final req = invocation.positionalArguments[0] as EditProfileRequestDto;
            expect(req.firstName, 'x');
            expect(req.lastName, 'y');
            expect(req.email, 'e@test.com');
            expect(req.phone, '+1');
            return SuccessBaseResponse<UserDto>(data: userDto);
          },
        );

        await repository.editProfile(
          firstName: '  x ',
          lastName: ' y',
          email: ' e@test.com ',
          phone: ' +1 ',
        );

        verify(mockRemoteDataSource.editProfile(any)).called(1);
      });
    });
  });
}
