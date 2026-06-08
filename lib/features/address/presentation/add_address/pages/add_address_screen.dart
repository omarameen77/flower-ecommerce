import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/core/location_data/current_location_service.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_cubit.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flower/features/address/presentation/add_address/widgets/add_address_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressScreen extends StatelessWidget {
  final AddressEntity? editAddress;

  const AddAddressScreen({super.key, this.editAddress});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<AddAddressCubit>()..doIntent(const LoadLookupsIntent()),
      child: _AddAddressView(editAddress: editAddress),
    );
  }
}

class _AddAddressView extends StatefulWidget {
  final AddressEntity? editAddress;
  const _AddAddressView({this.editAddress});

  @override
  State<_AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<_AddAddressView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final edit = widget.editAddress;
      if (edit != null && edit.lat.isNotEmpty && edit.long.isNotEmpty) {
        context.read<AddAddressCubit>().doIntent(
          LocationPickedIntent(lat: edit.lat, long: edit.long),
        );
      } else {
        _resolveLocation();
      }
    });
  }

  Future<void> _resolveLocation() async {
    final loc = await CurrentLocationService.getCurrent();
    if (!mounted) return;
    if (!loc.granted) {
      CustomSnackBar.error(context, context.locationPermissionDenied);
      Navigator.pop(context);
      return;
    }
    context.read<AddAddressCubit>().doIntent(
      LocationPickedIntent(
        lat: loc.lat.toString(),
        long: loc.long.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.addressTitle),
      body: BlocListener<AddAddressCubit, AddAddressState>(
        listenWhen: (prev, curr) =>
            prev.addAddressState != curr.addAddressState,
        listener: _onStateChanged,
        child: AddAddressForm(editAddress: widget.editAddress),
      ),
    );
  }

  void _onStateChanged(BuildContext context, AddAddressState state) {
    final s = state.addAddressState;
    if (s.data != null) {
      CustomSnackBar.success(context, context.addressSaved);
      Navigator.pop(context, true);
    } else if (s.errorMessage != null) {
      CustomSnackBar.error(context, s.errorMessage!.tr());
    }
  }
}
