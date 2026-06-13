import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_cubit.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flower/features/address/presentation/add_address/widgets/add_address_form.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressScreen extends StatelessWidget {
  final AddressEntity? editAddress;

  const AddAddressScreen({super.key, this.editAddress});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<AddAddressCubit>()
          ..doIntent(LoadLookupsIntent(editAddress: editAddress));
        if (editAddress != null &&
            editAddress!.lat.isNotEmpty &&
            editAddress!.long.isNotEmpty) {
          cubit.doIntent(
            LocationPickedIntent(
              lat: editAddress!.lat,
              long: editAddress!.long,
            ),
          );
        } else {
          cubit.doIntent(const ResolveCurrentLocationIntent());
        }
        return cubit;
      },
      child: _AddAddressView(editAddress: editAddress),
    );
  }
}

class _AddAddressView extends StatelessWidget {
  final AddressEntity? editAddress;
  const _AddAddressView({this.editAddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.addressTitle),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddAddressCubit, AddAddressState>(
            listenWhen: (prev, curr) =>
                prev.addAddressState != curr.addAddressState,
            listener: _onSubmitStateChanged,
          ),
          BlocListener<AddAddressCubit, AddAddressState>(
            listenWhen: (prev, curr) =>
                !prev.locationDenied && curr.locationDenied,
            listener: (context, _) {
              CustomSnackBar.error(context, context.locationPermissionDenied);
              Navigator.pop(context);
            },
          ),
        ],
        child: AddAddressForm(editAddress: editAddress),
      ),
    );
  }

  void _onSubmitStateChanged(BuildContext context, AddAddressState state) {
    final s = state.addAddressState;
    if (s.data != null) {
      CustomSnackBar.success(context, context.addressSaved);
      context.read<SavedAddressesCubit>().doIntent(const LoadAddressesIntent());
      Navigator.pop(context, true);
    } else if (s.errorMessage != null) {
      CustomSnackBar.error(context, s.errorMessage!.tr());
    }
  }
}
