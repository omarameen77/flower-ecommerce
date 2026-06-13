import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutAddressCard extends StatelessWidget {
  const CheckoutAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SavedAddressesCubit>().state;
    final addresses =
        state.addressesState.data ?? const <AddressEntity>[];
    final current = state.currentAddress;

    return Container(
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(color: AppColors.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CheckoutConstants.shippingAddress,
            style: getSemiBoldStyle(
              context: context,
              fontSize: AppSize.s15,
              color: AppColors.textPrimary,
            ),
          ),
          const AppSizedBox(height: AppSize.s12),
          if (state.addressesState.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.s8),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (addresses.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.s8),
              child: Text(
                context.noSavedAddresses,
                style: getRegularStyle(
                  context: context,
                  color: AppColors.textSecondary,
                ),
              ),
            )
          else
            ...addresses.map((a) => _AddressTile(
                  address: a,
                  isSelected: a.id == current?.id,
                )),
          const AppSizedBox(height: AppSize.s8),
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, Routes.addAddress),
            icon: const Icon(Icons.add, size: AppSize.s18),
            label: Text(
              CheckoutConstants.addNewAddress,
              style: getMediumStyle(
                context: context,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  final AddressEntity address;
  final bool isSelected;

  const _AddressTile({
    required this.address,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<SavedAddressesCubit>()
            .doIntent(SelectAddressIntent(address.id));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSize.s4),
        child: Row(
          children: [
            const Icon(Icons.location_on_outlined,
                color: AppColors.textPrimary, size: AppSize.s20),
            const AppSizedBox(width: AppSize.s8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.street,
                    style: getMediumStyle(
                      context: context,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${address.city} - ${address.phone}',
                    style: getRegularStyle(
                      context: context,
                      color: AppColors.textSecondary,
                      fontSize: AppSize.s12,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String?>(
              value: address.id,
              groupValue: isSelected ? address.id : null,
              onChanged: (_) {
                context
                    .read<SavedAddressesCubit>()
                    .doIntent(SelectAddressIntent(address.id));
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
