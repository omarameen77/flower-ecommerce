import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/use_cases/get_addresses_use_case.dart';
import 'package:flower/features/address/domain/use_cases/remove_address_use_case.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_addresses_cubit_test.mocks.dart';

@GenerateMocks([GetAddressesUseCase, RemoveAddressUseCase])
void main() {
  late MockGetAddressesUseCase mockGetUseCase;
  late MockRemoveAddressUseCase mockRemoveUseCase;
  late SavedAddressesCubit cubit;

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

  setUpAll(() {
    provideDummy<BaseResponse<List<AddressEntity>>>(
      SuccessBaseResponse<List<AddressEntity>>(data: const []),
    );
  });

  setUp(() {
    mockGetUseCase = MockGetAddressesUseCase();
    mockRemoveUseCase = MockRemoveAddressUseCase();
    cubit = SavedAddressesCubit(mockGetUseCase, mockRemoveUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('saved addresses cubit', () {
    group('load addresses', () {
      test('emits [loading, success] when fetch succeeds', () async {
        when(
          mockGetUseCase(),
        ).thenAnswer((_) async => SuccessBaseResponse(data: addresses));

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            isA<SavedAddressesState>().having(
              (s) => s.addressesState.isLoading,
              'loading',
              true,
            ),
            isA<SavedAddressesState>().having(
              (s) => s.addressesState.data,
              'data',
              addresses,
            ),
          ]),
        );

        cubit.doIntent(const LoadAddressesIntent());
        await expectation;
      });

      test('emits [loading, error] when fetch fails', () async {
        when(mockGetUseCase()).thenAnswer(
          (_) async => ErrorBaseResponse(failure: Failure(message: 'boom')),
        );

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            isA<SavedAddressesState>().having(
              (s) => s.addressesState.isLoading,
              'loading',
              true,
            ),
            isA<SavedAddressesState>().having(
              (s) => s.addressesState.errorMessage,
              'errorMessage',
              'boom',
            ),
          ]),
        );

        cubit.doIntent(const LoadAddressesIntent());
        await expectation;
      });
    });

    group('delete address', () {
      test(
        'emits deletingId then refreshes list with backend response',
        () async {
          when(
            mockRemoveUseCase('1'),
          ).thenAnswer((_) async => SuccessBaseResponse(data: addresses));

          final expectation = expectLater(
            cubit.stream,
            emitsInOrder([
              isA<SavedAddressesState>().having(
                (s) => s.deletingId,
                'deletingId',
                '1',
              ),
              isA<SavedAddressesState>()
                  .having((s) => s.deletingId, 'deletingId', '')
                  .having((s) => s.addressesState.data, 'data', addresses),
            ]),
          );

          cubit.doIntent(const DeleteAddressIntent('1'));
          await expectation;
        },
      );

      test('emits deleteErrorMessage when remove fails', () async {
        when(mockRemoveUseCase('1')).thenAnswer(
          (_) async => ErrorBaseResponse(failure: Failure(message: 'boom')),
        );

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            isA<SavedAddressesState>().having(
              (s) => s.deletingId,
              'deletingId',
              '1',
            ),
            isA<SavedAddressesState>()
                .having((s) => s.deletingId, 'deletingId', '')
                .having(
                  (s) => s.deleteErrorMessage,
                  'deleteErrorMessage',
                  'boom',
                ),
          ]),
        );

        cubit.doIntent(const DeleteAddressIntent('1'));
        await expectation;
      });
    });

    test('reset() wipes the cached list back to initial', () async {
      when(
        mockGetUseCase(),
      ).thenAnswer((_) async => SuccessBaseResponse(data: addresses));
      cubit.doIntent(const LoadAddressesIntent());
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.addressesState.data, addresses);

      cubit.reset();

      expect(cubit.state.addressesState.data, isNull);
      expect(cubit.state.deletingId, isEmpty);
      expect(cubit.state.deleteErrorMessage, isNull);
    });
  });
}
