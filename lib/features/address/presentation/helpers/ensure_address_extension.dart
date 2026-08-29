import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension EnsureAddressOnContext on BuildContext {
  Future<bool> ensureUserHasAddress(String text) async {
    final cubit = read<SavedAddressesCubit>();
    if (cubit.state.addressesState.data == null) {
      if (!cubit.state.addressesState.isLoading) {
        cubit.doIntent(const LoadAddressesIntent());
      }
      await cubit.stream.firstWhere((state) => !state.addressesState.isLoading);
    }
    final hasAddress =
        (cubit.state.addressesState.data ?? const <AddressEntity>[]).isNotEmpty;
    if (!hasAddress) {
      CustomSnackBar.error(this, text);
      if (mounted) {
        Navigator.pushNamed(this, Routes.addAddress);
      }
    }
    return hasAddress;
  }
}
