import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/use_cases/add_address_use_case.dart';
import 'package:flower/features/address/domain/use_cases/update_address_use_case.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_cubit.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_address_cubit_test.mocks.dart';

@GenerateMocks([AddAddressUseCase, UpdateAddressUseCase])
void main() {
  late MockAddAddressUseCase mockAddUseCase;
  late MockUpdateAddressUseCase mockUpdateUseCase;
  late AddAddressCubit cubit;

  setUpAll(() {
    provideDummy<BaseResponse<List<AddressEntity>>>(
      SuccessBaseResponse<List<AddressEntity>>(data: const []),
    );
  });

  setUp(() {
    mockAddUseCase = MockAddAddressUseCase();
    mockUpdateUseCase = MockUpdateAddressUseCase();
    cubit = AddAddressCubit(mockAddUseCase, mockUpdateUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('add address cubit', () {
    test('LocationPickedIntent updates lat/long in state', () {
      cubit.doIntent(const LocationPickedIntent(lat: '30.04', long: '31.23'));

      expect(cubit.state.lat, '30.04');
      expect(cubit.state.long, '31.23');
    });

    group('submit (add mode)', () {
      const intent = SubmitAddAddressIntent(
        street: 'Home',
        phone: '01010700700',
        username: 'hamza',
      );

      test('emits [loading, success] when add succeeds', () async {
        const addresses = <AddressEntity>[
          AddressEntity(
            id: '1',
            street: 'Home',
            phone: '01010700700',
            city: '',
            lat: '',
            long: '',
            username: 'hamza',
          ),
        ];
        when(
          mockAddUseCase(
            street: anyNamed('street'),
            phone: anyNamed('phone'),
            city: anyNamed('city'),
            lat: anyNamed('lat'),
            long: anyNamed('long'),
            username: anyNamed('username'),
          ),
        ).thenAnswer((_) async => SuccessBaseResponse(data: addresses));

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            isA<AddAddressState>().having(
              (s) => s.addAddressState.isLoading,
              'loading',
              true,
            ),
            isA<AddAddressState>()
                .having((s) => s.addAddressState.isLoading, 'loading', false)
                .having((s) => s.addAddressState.data, 'data', isNotNull),
          ]),
        );

        cubit.doIntent(intent);
        await expectation;

        verify(
          mockAddUseCase(
            street: 'Home',
            phone: '01010700700',
            city: anyNamed('city'),
            lat: anyNamed('lat'),
            long: anyNamed('long'),
            username: 'hamza',
          ),
        ).called(1);
        verifyNever(
          mockUpdateUseCase(
            id: anyNamed('id'),
            street: anyNamed('street'),
            phone: anyNamed('phone'),
            city: anyNamed('city'),
            lat: anyNamed('lat'),
            long: anyNamed('long'),
            username: anyNamed('username'),
          ),
        );
      });

      test('emits [loading, error] when add fails', () async {
        when(
          mockAddUseCase(
            street: anyNamed('street'),
            phone: anyNamed('phone'),
            city: anyNamed('city'),
            lat: anyNamed('lat'),
            long: anyNamed('long'),
            username: anyNamed('username'),
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse(failure: Failure(message: 'boom')),
        );

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            isA<AddAddressState>().having(
              (s) => s.addAddressState.isLoading,
              'loading',
              true,
            ),
            isA<AddAddressState>().having(
              (s) => s.addAddressState.errorMessage,
              'errorMessage',
              'boom',
            ),
          ]),
        );

        cubit.doIntent(intent);
        await expectation;
      });
    });

    group('submit (edit mode)', () {
      const intent = SubmitAddAddressIntent(
        street: 'Hom',
        phone: '01010700700',
        username: 'hamza',
        editingId: '1',
      );

      test('routes to UpdateAddressUseCase when editingId is set', () async {
        when(
          mockUpdateUseCase(
            id: anyNamed('id'),
            street: anyNamed('street'),
            phone: anyNamed('phone'),
            city: anyNamed('city'),
            lat: anyNamed('lat'),
            long: anyNamed('long'),
            username: anyNamed('username'),
          ),
        ).thenAnswer((_) async => SuccessBaseResponse(data: const []));

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            isA<AddAddressState>().having(
              (s) => s.addAddressState.isLoading,
              'loading',
              true,
            ),
            isA<AddAddressState>()
                .having((s) => s.addAddressState.isLoading, 'loading', false)
                .having((s) => s.addAddressState.data, 'data', isNotNull),
          ]),
        );

        cubit.doIntent(intent);
        await expectation;

        verify(
          mockUpdateUseCase(
            id: '1',
            street: 'Hom',
            phone: '01010700700',
            city: anyNamed('city'),
            lat: anyNamed('lat'),
            long: anyNamed('long'),
            username: 'hamza',
          ),
        ).called(1);
        verifyNever(
          mockAddUseCase(
            street: anyNamed('street'),
            phone: anyNamed('phone'),
            city: anyNamed('city'),
            lat: anyNamed('lat'),
            long: anyNamed('long'),
            username: anyNamed('username'),
          ),
        );
      });
    });
  });
}
