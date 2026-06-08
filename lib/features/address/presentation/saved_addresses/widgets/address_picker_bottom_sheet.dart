import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAddressPickerSheet(BuildContext context) {
  final cubit = context.read<SavedAddressesCubit>();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: const _AddressPickerSheet(),
    ),
  );
}

class _AddressPickerSheet extends StatelessWidget {
  const _AddressPickerSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: BlocBuilder<SavedAddressesCubit, SavedAddressesState>(
          buildWhen: (prev, curr) =>
              prev.addressesState != curr.addressesState ||
              prev.selectedAddressId != curr.selectedAddressId,
          builder: (context, state) {
            final addresses =
                state.addressesState.data ?? const <AddressEntity>[];
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.savedAddressTitle,
                  style: getSemiBoldStyle(
                    context: context,
                    color: AppColors.textPrimary,
                    fontSize: FontSizeManager.s18,
                  ),
                ),
                const AppSizedBox(height: AppSize.s12),
                if (addresses.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
                    child: Text(
                      context.noSavedAddresses,
                      style: getRegularStyle(
                        context: context,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      separatorBuilder: (_, _) =>
                          const Divider(height: 1, color: AppColors.border),
                      itemBuilder: (_, i) {
                        final a = addresses[i];
                        final selected =
                            (state.currentAddress?.id ?? '') == a.id;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.location_on_outlined,
                            color: selected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                          title: Text(
                            a.city,
                            style: getSemiBoldStyle(
                              context: context,
                              color: AppColors.textPrimary,
                              fontSize: FontSizeManager.s14,
                            ),
                          ),
                          subtitle: Text(
                            a.street,
                            style: getRegularStyle(
                              context: context,
                              color: AppColors.textSecondary,
                              fontSize: FontSizeManager.s12,
                            ),
                          ),
                          trailing: selected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                )
                              : null,
                          onTap: () {
                            context.read<SavedAddressesCubit>().doIntent(
                              SelectAddressIntent(a.id),
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                const AppSizedBox(height: AppSize.s8),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.addAddress);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.primary,
                    ),
                    label: Text(
                      context.addNewAddress,
                      style: getMediumStyle(
                        context: context,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
