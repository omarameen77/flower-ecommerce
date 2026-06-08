import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_loading_widget.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flower/features/address/presentation/saved_addresses/widgets/saved_address_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<SavedAddressesCubit>();
    if (cubit.state.addressesState.data == null) {
      cubit.doIntent(const LoadAddressesIntent());
    }
  }

  Future<void> _openAdd(BuildContext context, {AddressEntity? edit}) async {
    final cubit = context.read<SavedAddressesCubit>();
    final result = await Navigator.pushNamed(
      context,
      Routes.addAddress,
      arguments: edit,
    );
    if (result == true) {
      cubit.doIntent(const LoadAddressesIntent());
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    AddressEntity address,
  ) async {
    final cubit = context.read<SavedAddressesCubit>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.deleteAddressTitle),
        content: Text(context.deleteAddressMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              context.delete,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (ok == true) {
      cubit.doIntent(DeleteAddressIntent(address.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.savedAddressTitle),
      body: BlocListener<SavedAddressesCubit, SavedAddressesState>(
        listenWhen: (prev, curr) =>
            prev.deleteErrorMessage != curr.deleteErrorMessage &&
            curr.deleteErrorMessage != null,
        listener: (context, state) {
          CustomSnackBar.error(context, state.deleteErrorMessage!.tr());
        },
        child: BlocBuilder<SavedAddressesCubit, SavedAddressesState>(
          buildWhen: (prev, curr) =>
              prev.addressesState != curr.addressesState ||
              prev.deletingId != curr.deletingId,
          builder: (context, state) {
            final s = state.addressesState;
            if (s.isLoading) return const AppLoadingWidget();
            if (s.errorMessage != null) {
              return Center(child: Text(s.errorMessage!.tr()));
            }
            final addresses = s.data ?? const <AddressEntity>[];
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                children: [
                  Expanded(
                    child: addresses.isEmpty
                        ? Center(
                            child: Text(
                              context.noSavedAddresses,
                              style: getRegularStyle(
                                context: context,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: addresses.length,
                            separatorBuilder: (_, _) =>
                                const AppSizedBox(height: AppSize.s12),
                            itemBuilder: (_, i) {
                              final a = addresses[i];
                              return SavedAddressItem(
                                address: a,
                                isDeleting: state.deletingId == a.id,
                                onEdit: () => _openAdd(context, edit: a),
                                onDelete: () => _confirmDelete(context, a),
                              );
                            },
                          ),
                  ),
                  const AppSizedBox(height: AppSize.s16),
                  PrimaryButton(
                    text: context.addNewAddress,
                    onTap: () => _openAdd(context),
                  ),
                  const AppSizedBox(height: AppSize.s8),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
