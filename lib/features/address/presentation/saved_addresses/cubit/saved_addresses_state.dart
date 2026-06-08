part of 'saved_addresses_cubit.dart';

class SavedAddressesState extends Equatable {
  final BaseState<List<AddressEntity>> addressesState;

  final String deletingId;
  final String? deleteErrorMessage;

  const SavedAddressesState({
    this.addressesState = const BaseState(),
    this.deletingId = '',
    this.deleteErrorMessage,
  });

  SavedAddressesState copyWith({
    BaseState<List<AddressEntity>>? addressesState,
    String? deletingId,
    String? deleteErrorMessage,
    bool clearDeleteError = false,
  }) {
    return SavedAddressesState(
      addressesState: addressesState ?? this.addressesState,
      deletingId: deletingId ?? this.deletingId,
      deleteErrorMessage: clearDeleteError
          ? null
          : (deleteErrorMessage ?? this.deleteErrorMessage),
    );
  }

  @override
  List<Object?> get props => [addressesState, deletingId, deleteErrorMessage];
}
