import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/entities/current_location.dart';
import 'package:flower/features/address/domain/entities/location_item.dart';
import 'package:flower/features/address/domain/use_cases/add_address_use_case.dart';
import 'package:flower/features/address/domain/use_cases/address_params.dart';
import 'package:flower/features/address/domain/use_cases/get_current_location_use_case.dart';
import 'package:flower/features/address/domain/use_cases/load_location_lookups_use_case.dart';
import 'package:flower/features/address/domain/use_cases/update_address_use_case.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_cubit.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_address_cubit_test.mocks.dart';

@GenerateMocks([
  AddAddressUseCase,
  UpdateAddressUseCase,
  LoadLocationLookupsUseCase,
  GetCurrentLocationUseCase,
])
void main() {
  late MockAddAddressUseCase mockAddUseCase;
  late MockUpdateAddressUseCase mockUpdateUseCase;
  late MockLoadLocationLookupsUseCase mockLoadLookupsUseCase;
  late MockGetCurrentLocationUseCase mockGetCurrentLocationUseCase;
  late AddAddressCubit cubit;

  setUpAll(() {
    provideDummy<BaseResponse<List<AddressEntity>>>(
      SuccessBaseResponse<List<AddressEntity>>(data: const []),
    );
  });

  setUp(() {
    mockAddUseCase = MockAddAddressUseCase();
    mockUpdateUseCase = MockUpdateAddressUseCase();
    mockLoadLookupsUseCase = MockLoadLocationLookupsUseCase();
    mockGetCurrentLocationUseCase = MockGetCurrentLocationUseCase();
    cubit = AddAddressCubit(
      mockAddUseCase,
      mockUpdateUseCase,
      mockLoadLookupsUseCase,
      mockGetCurrentLocationUseCase,
    );
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

    test('LoadLookupsIntent populates cities and areas', () async {
      const cities = [CityItem(id: '1', nameEn: 'Giza', nameAr: 'الجيزة')];
      const areas = [
        AreaItem(id: 'a1', cityId: '1', nameEn: 'Dokki', nameAr: 'الدقي'),
      ];
      when(mockLoadLookupsUseCase()).thenAnswer(
        (_) async => const LocationLookups(cities: cities, areas: areas),
      );

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          isA<AddAddressState>()
              .having((s) => s.cities, 'cities', cities)
              .having((s) => s.allAreas, 'allAreas', areas),
        ]),
      );

      cubit.doIntent(const LoadLookupsIntent());
      await expectation;
    });

    test('ResolveCurrentLocationIntent emits lat/long when granted', () async {
      when(mockGetCurrentLocationUseCase()).thenAnswer(
        (_) async =>
            const CurrentLocation(lat: 30.04, long: 31.23, granted: true),
      );

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          isA<AddAddressState>()
              .having((s) => s.lat, 'lat', '30.04')
              .having((s) => s.long, 'long', '31.23')
              .having((s) => s.locationDenied, 'locationDenied', false),
        ]),
      );

      cubit.doIntent(const ResolveCurrentLocationIntent());
      await expectation;
    });

    test(
      'ResolveCurrentLocationIntent flips locationDenied when denied',
      () async {
        when(
          mockGetCurrentLocationUseCase(),
        ).thenAnswer((_) async => CurrentLocation.fallback);

        final expectation = expectLater(
          cubit.stream,
          emitsInOrder([
            isA<AddAddressState>().having(
              (s) => s.locationDenied,
              'locationDenied',
              true,
            ),
          ]),
        );

        cubit.doIntent(const ResolveCurrentLocationIntent());
        await expectation;
      },
    );

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
          mockAddUseCase(any),
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
            argThat(
              isA<AddressParams>()
                  .having((p) => p.street, 'street', 'Home')
                  .having((p) => p.phone, 'phone', '01010700700')
                  .having((p) => p.username, 'username', 'hamza'),
            ),
          ),
        ).called(1);
        verifyNever(
          mockUpdateUseCase(id: anyNamed('id'), params: anyNamed('params')),
        );
      });

      test('emits [loading, error] when add fails', () async {
        when(mockAddUseCase(any)).thenAnswer(
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
          mockUpdateUseCase(id: anyNamed('id'), params: anyNamed('params')),
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
            params: argThat(
              isA<AddressParams>()
                  .having((p) => p.street, 'street', 'Hom')
                  .having((p) => p.phone, 'phone', '01010700700')
                  .having((p) => p.username, 'username', 'hamza'),
              named: 'params',
            ),
          ),
        ).called(1);
        verifyNever(mockAddUseCase(any));
      });
    });
  });
}
