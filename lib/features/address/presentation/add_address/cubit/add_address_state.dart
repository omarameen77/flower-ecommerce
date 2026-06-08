part of 'add_address_cubit.dart';

class AddAddressState extends Equatable {
  final BaseState<List<AddressEntity>> addAddressState;

  final List<CityItem> cities;
  final List<AreaItem> allAreas;
  final List<AreaItem> filteredAreas;

  final CityItem? selectedCity;
  final AreaItem? selectedArea;

  final String lat;
  final String long;

  const AddAddressState({
    this.addAddressState = const BaseState(),
    this.cities = const [],
    this.allAreas = const [],
    this.filteredAreas = const [],
    this.selectedCity,
    this.selectedArea,
    this.lat = '',
    this.long = '',
  });

  AddAddressState copyWith({
    BaseState<List<AddressEntity>>? addAddressState,
    List<CityItem>? cities,
    List<AreaItem>? allAreas,
    List<AreaItem>? filteredAreas,
    CityItem? selectedCity,
    AreaItem? selectedArea,
    bool clearSelectedArea = false,
    String? lat,
    String? long,
  }) {
    return AddAddressState(
      addAddressState: addAddressState ?? this.addAddressState,
      cities: cities ?? this.cities,
      allAreas: allAreas ?? this.allAreas,
      filteredAreas: filteredAreas ?? this.filteredAreas,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedArea: clearSelectedArea
          ? null
          : (selectedArea ?? this.selectedArea),
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  @override
  List<Object?> get props => [
    addAddressState,
    cities,
    allAreas,
    filteredAreas,
    selectedCity,
    selectedArea,
    lat,
    long,
  ];
}
