import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/api/api_client/address_api_client.dart';
import 'package:flower/features/address/api/datasources/address_remote_data_source_impl.dart';
import 'package:flower/features/address/data/models/request/add_address_request.dart';
import 'package:flower/features/address/data/models/response/addresses_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AddressApiClient])
void main() {
  late MockAddressApiClient mockApiClient;
  late AddressRemoteDataSourceImpl dataSource;

  setUpAll(() {
    provideDummy<AddressesResponseDto>(AddressesResponseDto());
  });

  setUp(() {
    mockApiClient = MockAddressApiClient();
    dataSource = AddressRemoteDataSourceImpl(addressApiClient: mockApiClient);
  });

  group('address remote data source impl', () {
    group('getAddresses', () {
      test('returns SuccessBaseResponse when api call succeeds', () async {
        final response = AddressesResponseDto(addresses: const []);
        when(mockApiClient.getAddresses()).thenAnswer((_) async => response);

        final result = await dataSource.getAddresses();

        expect(result, isA<SuccessBaseResponse<AddressesResponseDto>>());
        verify(mockApiClient.getAddresses()).called(1);
      });

      test('returns ErrorBaseResponse when api call throws', () async {
        when(
          mockApiClient.getAddresses(),
        ).thenThrow(Exception('network error'));

        final result = await dataSource.getAddresses();

        expect(result, isA<ErrorBaseResponse<AddressesResponseDto>>());
        expect(
          (result as ErrorBaseResponse<AddressesResponseDto>).failure.message,
          isNotNull,
        );
      });
    });

    group('addAddress', () {
      test('returns SuccessBaseResponse when api call succeeds', () async {
        final request = AddAddressRequestDto(street: 'Home', city: 'Giza');
        final response = AddressesResponseDto(address: const []);
        when(mockApiClient.addAddress(any)).thenAnswer((_) async => response);

        final result = await dataSource.addAddress(request);

        expect(result, isA<SuccessBaseResponse<AddressesResponseDto>>());
        verify(mockApiClient.addAddress(any)).called(1);
      });

      test('returns ErrorBaseResponse when api call throws', () async {
        final request = AddAddressRequestDto(street: 'Home', city: 'Giza');
        when(
          mockApiClient.addAddress(any),
        ).thenThrow(Exception('network error'));

        final result = await dataSource.addAddress(request);

        expect(result, isA<ErrorBaseResponse<AddressesResponseDto>>());
      });
    });

    group('updateAddress', () {
      test('returns SuccessBaseResponse when api call succeeds', () async {
        final request = AddAddressRequestDto(street: 'Hom', city: 'Giza');
        final response = AddressesResponseDto(addresses: const []);
        when(
          mockApiClient.updateAddress(any, any),
        ).thenAnswer((_) async => response);

        final result = await dataSource.updateAddress(
          id: '1',
          request: request,
        );

        expect(result, isA<SuccessBaseResponse<AddressesResponseDto>>());
        verify(mockApiClient.updateAddress('1', any)).called(1);
      });

      test('returns ErrorBaseResponse when api call throws', () async {
        final request = AddAddressRequestDto(street: 'Hom', city: 'Giza');
        when(
          mockApiClient.updateAddress(any, any),
        ).thenThrow(Exception('network error'));

        final result = await dataSource.updateAddress(
          id: '1',
          request: request,
        );

        expect(result, isA<ErrorBaseResponse<AddressesResponseDto>>());
      });
    });

    group('removeAddress', () {
      test('returns SuccessBaseResponse when api call succeeds', () async {
        final response = AddressesResponseDto(addresses: const []);
        when(
          mockApiClient.removeAddress('1'),
        ).thenAnswer((_) async => response);

        final result = await dataSource.removeAddress('1');

        expect(result, isA<SuccessBaseResponse<AddressesResponseDto>>());
        verify(mockApiClient.removeAddress('1')).called(1);
      });

      test('returns ErrorBaseResponse when api call throws', () async {
        when(
          mockApiClient.removeAddress('1'),
        ).thenThrow(Exception('network error'));

        final result = await dataSource.removeAddress('1');

        expect(result, isA<ErrorBaseResponse<AddressesResponseDto>>());
      });
    });
  });
}
