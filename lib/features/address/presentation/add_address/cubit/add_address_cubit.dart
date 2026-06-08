import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/location_data/egypt_location_loader.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/use_cases/add_address_use_case.dart';
import 'package:flower/features/address/domain/use_cases/update_address_use_case.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'add_address_state.dart';

@injectable
class AddAddressCubit extends Cubit<AddAddressState> {
  final AddAddressUseCase _addUseCase;
  final UpdateAddressUseCase _updateUseCase;

  AddAddressCubit(this._addUseCase, this._updateUseCase)
    : super(const AddAddressState());

  void doIntent(AddAddressIntent intent) {
    switch (intent) {
      case LoadLookupsIntent():
        _loadLookups();
      case CitySelectedIntent():
        _onCitySelected(intent.city);
      case AreaSelectedIntent():
        emit(state.copyWith(selectedArea: intent.area));
      case LocationPickedIntent():
        emit(state.copyWith(lat: intent.lat, long: intent.long));
      case SubmitAddAddressIntent():
        _submitAddress(intent);
    }
  }

  Future<void> _loadLookups() async {
    final cities = await EgyptLocationLoader.loadCities();
    final areas = await EgyptLocationLoader.loadAreas();
    emit(state.copyWith(cities: cities, allAreas: areas));
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
    final city = state.selectedCity?.nameEn ?? '';
    final response = intent.editingId != null
        ? await _updateUseCase(
            id: intent.editingId!,
            street: intent.street,
            phone: intent.phone,
            city: city,
            lat: state.lat,
            long: state.long,
            username: intent.username,
          )
        : await _addUseCase(
            street: intent.street,
            phone: intent.phone,
            city: city,
            lat: state.lat,
            long: state.long,
            username: intent.username,
          );
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
