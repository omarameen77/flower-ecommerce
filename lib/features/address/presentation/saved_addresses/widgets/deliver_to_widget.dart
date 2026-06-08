import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_intents.dart';
import 'package:flower/features/address/presentation/saved_addresses/widgets/address_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliverToWidget extends StatefulWidget {
  const DeliverToWidget({super.key});

  @override
  State<DeliverToWidget> createState() => _DeliverToWidgetState();
}

class _DeliverToWidgetState extends State<DeliverToWidget> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<SavedAddressesCubit>();
    if (cubit.state.addressesState.data == null &&
        !cubit.state.addressesState.isLoading) {
      cubit.doIntent(const LoadAddressesIntent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedAddressesCubit, SavedAddressesState>(
      buildWhen: (prev, curr) =>
          prev.addressesState != curr.addressesState ||
          prev.selectedAddressId != curr.selectedAddressId,
      builder: (context, state) {
        final addresses =
            state.addressesState.data ?? const <AddressEntity>[];
        if (addresses.isEmpty) {
          return _CreateAddressButton(
            onTap: () => Navigator.pushNamed(context, Routes.addAddress),
          );
        }
        return _DeliverToRow(
          label: state.currentAddress?.street ?? '',
          onTap: () => showAddressPickerSheet(context),
        );
      },
    );
  }
}

class _DeliverToRow extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _DeliverToRow({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: AppColors.textPrimary,
              size: 20,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Deliver to ',
                      style: getRegularStyle(
                        context: context,
                        fontSize: FontSizeManager.s14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: label,
                      style: getSemiBoldStyle(
                        context: context,
                        fontSize: FontSizeManager.s14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primary,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateAddressButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CreateAddressButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add_location_alt_outlined, size: 18),
        label: Text(
          context.addNewAddress,
          style: getMediumStyle(
            context: context,
            fontSize: FontSizeManager.s14,
            color: AppColors.primary,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
