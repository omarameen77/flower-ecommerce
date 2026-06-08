import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/address/data/datasources/address_remote_data_source.dart';
import 'package:flower/features/address/data/models/response/address_dto.dart';
import 'package:flower/features/address/data/models/response/addresses_response.dart';
import 'package:flower/features/address/data/repositories/address_repo_impl.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_repo_impl_test.mocks.dart';

@GenerateMocks([AddressRemoteDataSourceContract])
void main() {
  late MockAddressRemoteDataSourceContract mockDataSource;
  late AddressRepoImpl repo;

  setUpAll(() {
    provideDummy<BaseResponse<AddressesResponseDto>>(
      SuccessBaseResponse<AddressesResponseDto>(data: AddressesResponseDto()),
    );
  });

  setUp(() {
    mockDataSource = MockAddressRemoteDataSourceContract();
    repo = AddressRepoImpl(addressRemoteDataSourceContract: mockDataSource);
  });

  group('address repo impl', () {
    group('getAddresses', () {
      test('should map DTO list to entity list on success', () async {
        final responseDto = AddressesResponseDto(
          addresses: [
            AddressDto(
              id: '1',
              street: 'Home',
              phone: '01010700700',
              city: 'Giza',
              lat: '30.04',
              long: '31.23',
              username: 'hamza',
            ),
          ],
        );

        when(mockDataSource.getAddresses()).thenAnswer(
          (_) async =>
              SuccessBaseResponse<AddressesResponseDto>(data: responseDto),
        );

        final result = await repo.getAddresses();

        expect(result, isA<SuccessBaseResponse<List<AddressEntity>>>());
        final data = (result as SuccessBaseResponse<List<AddressEntity>>).data;
        expect(data, hasLength(1));
        expect(data.first.id, '1');
        expect(data.first.city, 'Giza');
      });

      test('should preserve failure on error', () async {
        final failure = Failure(message: 'boom');
        when(mockDataSource.getAddresses()).thenAnswer(
          (_) async =>
              ErrorBaseResponse<AddressesResponseDto>(failure: failure),
        );

        final result = await repo.getAddresses();

        expect(result, isA<ErrorBaseResponse<List<AddressEntity>>>());
        expect(
          (result as ErrorBaseResponse<List<AddressEntity>>).failure,
          failure,
        );
      });
    });

    group('addAddress', () {
      test('should map DTO list to entity list on success', () async {
        final responseDto = AddressesResponseDto(
          address: [AddressDto(id: '2', street: 'Home', city: 'Giza')],
        );
        when(
          mockDataSource.addAddress(any),
        ).thenAnswer((_) async => SuccessBaseResponse(data: responseDto));

        final result = await repo.addAddress(
          street: 'Home',
          phone: '01010700700',
          city: 'Giza',
          lat: '30.04',
          long: '31.23',
          username: 'hamza',
        );

        expect(result, isA<SuccessBaseResponse<List<AddressEntity>>>());
        final data = (result as SuccessBaseResponse<List<AddressEntity>>).data;
        expect(data, hasLength(1));
        expect(data.first.id, '2');
        verify(mockDataSource.addAddress(any)).called(1);
      });

      test('should preserve failure on error', () async {
        final failure = Failure(message: 'boom');
        when(
          mockDataSource.addAddress(any),
        ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

        final result = await repo.addAddress(
          street: 'Home',
          phone: '01010700700',
          city: 'Giza',
          lat: '30.04',
          long: '31.23',
          username: 'hamza',
        );

        expect(result, isA<ErrorBaseResponse<List<AddressEntity>>>());
        expect(
          (result as ErrorBaseResponse<List<AddressEntity>>).failure,
          failure,
        );
      });
    });

    group('updateAddress', () {
      test('should map DTO list to entity list on success', () async {
        final responseDto = AddressesResponseDto(
          addresses: [AddressDto(id: '1', street: 'Hom', city: 'Giza')],
        );
        when(
          mockDataSource.updateAddress(
            id: anyNamed('id'),
            request: anyNamed('request'),
          ),
        ).thenAnswer((_) async => SuccessBaseResponse(data: responseDto));

        final result = await repo.updateAddress(
          id: '1',
          street: 'Hom',
          phone: '01010700700',
          city: 'Giza',
          lat: '30.04',
          long: '31.23',
          username: 'hamza',
        );

        expect(result, isA<SuccessBaseResponse<List<AddressEntity>>>());
        verify(
          mockDataSource.updateAddress(id: '1', request: anyNamed('request')),
        ).called(1);
      });

      test('should preserve failure on error', () async {
        final failure = Failure(message: 'boom');
        when(
          mockDataSource.updateAddress(
            id: anyNamed('id'),
            request: anyNamed('request'),
          ),
        ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

        final result = await repo.updateAddress(
          id: '1',
          street: 'Hom',
          phone: '01010700700',
          city: 'Giza',
          lat: '30.04',
          long: '31.23',
          username: 'hamza',
        );

        expect(result, isA<ErrorBaseResponse<List<AddressEntity>>>());
      });
    });

    group('removeAddress', () {
      test('should map DTO list to entity list on success', () async {
        final responseDto = AddressesResponseDto(addresses: const []);
        when(
          mockDataSource.removeAddress('1'),
        ).thenAnswer((_) async => SuccessBaseResponse(data: responseDto));

        final result = await repo.removeAddress('1');

        expect(result, isA<SuccessBaseResponse<List<AddressEntity>>>());
        expect(
          (result as SuccessBaseResponse<List<AddressEntity>>).data,
          isEmpty,
        );
        verify(mockDataSource.removeAddress('1')).called(1);
      });

      test('should preserve failure on error', () async {
        final failure = Failure(message: 'boom');
        when(
          mockDataSource.removeAddress('1'),
        ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

        final result = await repo.removeAddress('1');

        expect(result, isA<ErrorBaseResponse<List<AddressEntity>>>());
        expect(
          (result as ErrorBaseResponse<List<AddressEntity>>).failure,
          failure,
        );
      });
    });
  });
}
