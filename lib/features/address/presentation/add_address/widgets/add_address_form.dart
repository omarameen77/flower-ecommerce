import 'package:easy_localization/easy_localization.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_cubit.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flower/features/address/presentation/add_address/widgets/address_map_picker.dart';
import 'package:flower/features/address/presentation/add_address/widgets/city_area_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressForm extends StatefulWidget {
  final AddressEntity? editAddress;

  const AddAddressForm({super.key, this.editAddress});

  @override
  State<AddAddressForm> createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _streetController;
  late final TextEditingController _phoneController;
  late final TextEditingController _recipientController;

  late final String _initialStreet;
  late final String _initialPhone;
  late final String _initialRecipient;
  late final String _initialCity;
  late final String _initialLat;
  late final String _initialLong;

  bool get _isEditing => widget.editAddress != null;

  @override
  void initState() {
    super.initState();
    final edit = widget.editAddress;
    _initialStreet = edit?.street ?? '';
    _initialPhone = edit?.phone ?? '';
    _initialRecipient = edit?.username ?? '';
    _initialCity = edit?.city ?? '';
    _initialLat = edit?.lat ?? '';
    _initialLong = edit?.long ?? '';
    _streetController = TextEditingController(text: _initialStreet);
    _phoneController = TextEditingController(text: _initialPhone);
    _recipientController = TextEditingController(text: _initialRecipient);
  }

  @override
  void dispose() {
    _streetController.dispose();
    _phoneController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  bool _isDirty(AddAddressState state) {
    if (_streetController.text != _initialStreet) return true;
    if (_phoneController.text != _initialPhone) return true;
    if (_recipientController.text != _initialRecipient) return true;
    if ((state.selectedCity?.nameEn ?? '') != _initialCity) return true;
    if (state.lat != _initialLat) return true;
    if (state.long != _initialLong) return true;
    return false;
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AddAddressCubit>().doIntent(
      SubmitAddAddressIntent(
        street: _streetController.text.trim(),
        phone: _phoneController.text.trim(),
        username: _recipientController.text.trim(),
        editingId: widget.editAddress?.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
        children: [
          const AppSizedBox(height: AppSize.s12),
          const AddressMapPicker(),
          const AppSizedBox(height: AppSize.s24),
          CustomTextField(
            controller: _streetController,
            labelText: context.addressLabel,
            hintText: context.enterAddress,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? context.enterAddress : null,
          ),
          const AppSizedBox(height: AppSize.s16),
          CustomTextField(
            controller: _phoneController,
            labelText: context.phoneNumber,
            hintText: context.enterPhoneNumber,
            keyboardType: TextInputType.phone,
            validator: (v) => AppValidator.phone(v)?.tr(),
          ),
          const AppSizedBox(height: AppSize.s16),
          CustomTextField(
            controller: _recipientController,
            labelText: context.recipientName,
            hintText: context.enterRecipientName,
            validator: (v) => AppValidator.name(v)?.tr(),
          ),
          const AppSizedBox(height: AppSize.s16),
          const CityAreaRow(),
          const AppSizedBox(height: AppSize.s50),
          BlocBuilder<AddAddressCubit, AddAddressState>(
            buildWhen: (prev, curr) =>
                prev.addAddressState.isLoading !=
                    curr.addAddressState.isLoading ||
                prev.selectedCity != curr.selectedCity ||
                prev.selectedArea != curr.selectedArea ||
                prev.lat != curr.lat ||
                prev.long != curr.long,
            builder: (context, state) {
              if (state.addAddressState.isLoading) {
                return const ButtonLoadingWidget();
              }
              return ListenableBuilder(
                listenable: Listenable.merge([
                  _streetController,
                  _phoneController,
                  _recipientController,
                ]),
                builder: (context, _) {
                  final hasAllText =
                      _streetController.text.trim().isNotEmpty &&
                      _phoneController.text.trim().isNotEmpty &&
                      _recipientController.text.trim().isNotEmpty;
                  final hasPickers =
                      state.selectedCity != null && state.selectedArea != null;
                  final dirtyOrAdd = !_isEditing || _isDirty(state);
                  return PrimaryButton(
                    text: context.saveAddress,
                    onTap: (hasAllText && hasPickers && dirtyOrAdd)
                        ? _onSubmit
                        : null,
                  );
                },
              );
            },
          ),
          const AppSizedBox(height: AppSize.s24),
        ],
      ),
    );
  }
}
