import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/use_cases/get_addresses_use_case.dart';
import 'package:flower/features/address/domain/use_cases/remove_address_use_case.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'saved_addresses_state.dart';

@lazySingleton
class SavedAddressesCubit extends Cubit<SavedAddressesState> {
  final GetAddressesUseCase _getAddressesUseCase;
  final RemoveAddressUseCase _removeAddressUseCase;

  SavedAddressesCubit(this._getAddressesUseCase, this._removeAddressUseCase)
    : super(const SavedAddressesState());

  void doIntent(SavedAddressesIntent intent) {
    switch (intent) {
      case LoadAddressesIntent():
        _loadAddresses();
      case DeleteAddressIntent():
        _deleteAddress(intent.id);
      case SelectAddressIntent():
        emit(state.copyWith(selectedAddressId: intent.id));
      case ResetSavedAddressesIntent():
        emit(const SavedAddressesState());
    }
  }

  Future<void> _loadAddresses() async {
    emit(state.copyWith(addressesState: const BaseState(isLoading: true)));
    final response = await _getAddressesUseCase();
    switch (response) {
      case SuccessBaseResponse<List<AddressEntity>>():
        emit(state.copyWith(addressesState: BaseState(data: response.data)));
      case ErrorBaseResponse<List<AddressEntity>>():
        emit(
          state.copyWith(
            addressesState: BaseState(errorMessage: response.failure.message),
          ),
        );
    }
  }

  Future<void> _deleteAddress(String id) async {
    emit(state.copyWith(deletingId: id, clearDeleteError: true));
    final response = await _removeAddressUseCase(id);
    switch (response) {
      case SuccessBaseResponse<List<AddressEntity>>():
        emit(
          state.copyWith(
            addressesState: BaseState(data: response.data),
            deletingId: '',
          ),
        );
      case ErrorBaseResponse<List<AddressEntity>>():
        emit(
          state.copyWith(
            deletingId: '',
            deleteErrorMessage: response.failure.message,
          ),
        );
    }
  }
}
