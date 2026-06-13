import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:flower/features/address/domain/use_cases/get_addresses_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_addresses_use_case_test.mocks.dart';

@GenerateMocks([AddressRepo])
void main() {
  late MockAddressRepo repo;
  late GetAddressesUseCase useCase;

  setUpAll(() {
    provideDummy<BaseResponse<List<AddressEntity>>>(
      SuccessBaseResponse<List<AddressEntity>>(data: const []),
    );
  });

  setUp(() {
    repo = MockAddressRepo();
    useCase = GetAddressesUseCase(repo);
  });

  test('returns the address list from repo on success', () async {
    const addresses = <AddressEntity>[
      AddressEntity(
        id: '1',
        street: 'Home',
        phone: '01010700700',
        city: 'Giza',
        lat: '30.04',
        long: '31.23',
        username: 'hamza',
      ),
    ];
    when(
      repo.getAddresses(),
    ).thenAnswer((_) async => SuccessBaseResponse(data: addresses));

    final result = await useCase();

    expect(result, isA<SuccessBaseResponse<List<AddressEntity>>>());
    expect(
      (result as SuccessBaseResponse<List<AddressEntity>>).data,
      addresses,
    );
    verify(repo.getAddresses()).called(1);
  });

  test('propagates error from repo', () async {
    final failure = Failure(message: 'boom');
    when(
      repo.getAddresses(),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await useCase();

    expect(result, isA<ErrorBaseResponse<List<AddressEntity>>>());
    expect(
      (result as ErrorBaseResponse<List<AddressEntity>>).failure.message,
      'boom',
    );
  });
}
