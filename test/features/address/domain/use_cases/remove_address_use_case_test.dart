import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:flower/features/address/domain/use_cases/remove_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remove_address_use_case_test.mocks.dart';

@GenerateMocks([AddressRepo])
void main() {
  late MockAddressRepo repo;
  late RemoveAddressUseCase useCase;

  setUpAll(() {
    provideDummy<BaseResponse<List<AddressEntity>>>(
      SuccessBaseResponse<List<AddressEntity>>(data: const []),
    );
  });

  setUp(() {
    repo = MockAddressRepo();
    useCase = RemoveAddressUseCase(repo);
  });

  test('forwards the id to repo.removeAddress on success', () async {
    when(
      repo.removeAddress('1'),
    ).thenAnswer((_) async => SuccessBaseResponse(data: const []));

    final result = await useCase('1');

    expect(result, isA<SuccessBaseResponse<List<AddressEntity>>>());
    verify(repo.removeAddress('1')).called(1);
  });

  test('propagates error from repo', () async {
    final failure = Failure(message: 'boom');
    when(
      repo.removeAddress('1'),
    ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

    final result = await useCase('1');

    expect(result, isA<ErrorBaseResponse<List<AddressEntity>>>());
    expect(
      (result as ErrorBaseResponse<List<AddressEntity>>).failure.message,
      'boom',
    );
  });
}
