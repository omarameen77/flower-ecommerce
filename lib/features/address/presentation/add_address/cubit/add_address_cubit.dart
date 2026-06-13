import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/entities/location_item.dart';
import 'package:flower/features/address/domain/use_cases/add_address_use_case.dart';
import 'package:flower/features/address/domain/use_cases/address_params.dart';
import 'package:flower/features/address/domain/use_cases/get_current_location_use_case.dart';
import 'package:flower/features/address/domain/use_cases/load_location_lookups_use_case.dart';
import 'package:flower/features/address/domain/use_cases/update_address_use_case.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'add_address_state.dart';

@injectable
class AddAddressCubit extends Cubit<AddAddressState> {
  final AddAddressUseCase _addUseCase;
  final UpdateAddressUseCase _updateUseCase;
  final LoadLocationLookupsUseCase _loadLookupsUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;

  AddAddressCubit(
    this._addUseCase,
    this._updateUseCase,
    this._loadLookupsUseCase,
    this._getCurrentLocationUseCase,
  ) : super(const AddAddressState());

  void doIntent(AddAddressIntent intent) {
    switch (intent) {
      case LoadLookupsIntent():
        _loadLookups(intent.editAddress);
      case CitySelectedIntent():
        _onCitySelected(intent.city);
      case AreaSelectedIntent():
        emit(state.copyWith(selectedArea: intent.area));
      case LocationPickedIntent():
        emit(state.copyWith(lat: intent.lat, long: intent.long));
      case ResolveCurrentLocationIntent():
        _resolveCurrentLocation();
      case SubmitAddAddressIntent():
        _submitAddress(intent);
    }
  }

  Future<void> _resolveCurrentLocation() async {
    final location = await _getCurrentLocationUseCase();
    if (!location.granted) {
      emit(state.copyWith(locationDenied: true));
      return;
    }
    emit(
      state.copyWith(
        lat: location.lat.toString(),
        long: location.long.toString(),
      ),
    );
  }

  Future<void> _loadLookups(AddressEntity? editAddress) async {
    final lookups = await _loadLookupsUseCase();
    final cities = lookups.cities;
    final areas = lookups.areas;
    if (editAddress == null) {
      emit(state.copyWith(cities: cities, allAreas: areas));
      return;
    }
    final matchedCity = cities.firstWhere(
      (c) =>
          c.nameEn.toLowerCase() == editAddress.city.toLowerCase() ||
          c.nameAr == editAddress.city,
      orElse: () => const CityItem(id: '', nameEn: '', nameAr: ''),
    );
    final filteredAreas = matchedCity.id.isEmpty
        ? const <AreaItem>[]
        : areas.where((a) => a.cityId == matchedCity.id).toList();
    emit(
      state.copyWith(
        cities: cities,
        allAreas: areas,
        filteredAreas: filteredAreas,
        selectedCity: matchedCity.id.isEmpty ? null : matchedCity,
        selectedArea: filteredAreas.isEmpty ? null : filteredAreas.first,
      ),
    );
  }

  void _onCitySelected(CityItem city) {
    final filteredAreas = state.allAreas
        .where((a) => a.cityId == city.id)
        .toList();
    emit(
      state.copyWith(
        selectedCity: city,
        selectedArea: null,
        clearSelectedArea: true,
        filteredAreas: filteredAreas,
      ),
    );
  }

  Future<void> _submitAddress(SubmitAddAddressIntent intent) async {
    emit(state.copyWith(addAddressState: const BaseState(isLoading: true)));
    final params = AddressParams(
      street: intent.street,
      phone: intent.phone,
      city: state.selectedCity?.nameEn ?? '',
      lat: state.lat,
      long: state.long,
      username: intent.username,
    );
    final response = intent.editingId != null
        ? await _updateUseCase(id: intent.editingId!, params: params)
        : await _addUseCase(params);
    switch (response) {
      case SuccessBaseResponse<List<AddressEntity>>():
        emit(state.copyWith(addAddressState: BaseState(data: response.data)));
      case ErrorBaseResponse<List<AddressEntity>>():
        emit(
          state.copyWith(
            addAddressState: BaseState(errorMessage: response.failure.message),
          ),
        );
    }
  }
}
