import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:flower/features/address/domain/use_cases/update_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_address_use_case_test.mocks.dart';

@GenerateMocks([AddressRepo])
void main() {
  late MockAddressRepo repo;
  late UpdateAddressUseCase useCase;

  setUpAll(() {
    provideDummy<BaseResponse<List<AddressEntity>>>(
      SuccessBaseResponse<List<AddressEntity>>(data: const []),
    );
  });

  setUp(() {
    repo = MockAddressRepo();
    useCase = UpdateAddressUseCase(repo);
  });

  test('forwards id and all fields to repo.updateAddress on success', () async {
    when(
      repo.updateAddress(
        id: anyNamed('id'),
        street: anyNamed('street'),
        phone: anyNamed('phone'),
        city: anyNamed('city'),
        lat: anyNamed('lat'),
        long: anyNamed('long'),
        username: anyNamed('username'),
      ),
    ).thenAnswer((_) async => SuccessBaseResponse(data: const []));

    final result = await useCase(
      id: '1',
      street: 'Home',
      phone: '01010700700',
      city: 'Giza',
      lat: '30.04',
      long: '31.23',
      username: 'hamza',
    );

    expect(result, isA<SuccessBaseResponse<List<AddressEntity>>>());
    verify(
      repo.updateAddress(
        id: '1',
        street: 'Home',
        phone: '01010700700',
        city: 'Giza',
        lat: '30.04',
        long: '31.23',
        username: 'hamza',
      ),
    ).called(1);
  });

  test('propagates error from repo', () async {
    final failure = Failure(message: 'boom');
    when(
      repo.updateAddress(
        id: anyNamed('id'),
        street: anyNamed('street'),
        phone: anyNamed('phone'),
        city: anyNamed('city'),
        lat: anyNamed('lat'),
        long: anyNamed('long'),
        username: anyNamed('username'),
      ),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await useCase(
      id: '1',
      street: 'Home',
      phone: '01010700700',
      city: 'Giza',
      lat: '30.04',
      long: '31.23',
      username: 'hamza',
    );

    expect(result, isA<ErrorBaseResponse<List<AddressEntity>>>());
    expect(
      (result as ErrorBaseResponse<List<AddressEntity>>).failure.message,
      'boom',
    );
  });
}
