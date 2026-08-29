part of 'saved_addresses_cubit.dart';

class SavedAddressesState extends Equatable {
  final BaseState<List<AddressEntity>> addressesState;

  final String deletingId;
  final String? deleteErrorMessage;
  final String? selectedAddressId;

  const SavedAddressesState({
    this.addressesState = const BaseState(),
    this.deletingId = '',
    this.deleteErrorMessage,
    this.selectedAddressId,
  });

  SavedAddressesState copyWith({
    BaseState<List<AddressEntity>>? addressesState,
    String? deletingId,
    String? deleteErrorMessage,
    bool clearDeleteError = false,
    String? selectedAddressId,
  }) {
    return SavedAddressesState(
      addressesState: addressesState ?? this.addressesState,
      deletingId: deletingId ?? this.deletingId,
      deleteErrorMessage: clearDeleteError
          ? null
          : (deleteErrorMessage ?? this.deleteErrorMessage),
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
    );
  }

  AddressEntity? get currentAddress {
    final list = addressesState.data ?? const <AddressEntity>[];
    if (list.isEmpty) return null;
    if (selectedAddressId != null) {
      for (final a in list) {
        if (a.id == selectedAddressId) return a;
      }
    }
    return list.last;
  }

  @override
  List<Object?> get props => [
    addressesState,
    deletingId,
    deleteErrorMessage,
    selectedAddressId,
  ];
}
