import 'package:flower/core/layout/app_size.dart';
import 'package:flower/features/address/domain/entities/location_item.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_cubit.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityAreaRow extends StatelessWidget {
  const CityAreaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAddressCubit, AddAddressState>(
      buildWhen: (prev, curr) =>
          prev.cities != curr.cities ||
          prev.filteredAreas != curr.filteredAreas ||
          prev.selectedCity != curr.selectedCity ||
          prev.selectedArea != curr.selectedArea,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(child: _cityDropdown(context, state)),
            const SizedBox(width: AppSize.s12),
            Expanded(child: _areaDropdown(context, state)),
          ],
        );
      },
    );
  }

  Widget _cityDropdown(BuildContext context, AddAddressState state) {
    return DropdownButtonFormField<CityItem>(
      isExpanded: true,
      initialValue: state.selectedCity,
      items: state.cities
          .map(
            (c) => DropdownMenuItem(
              value: c,
              child: Text(c.nameEn, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: state.cities.isEmpty
          ? null
          : (city) {
              if (city != null) {
                context.read<AddAddressCubit>().doIntent(
                  CitySelectedIntent(city),
                );
              }
            },
      decoration: InputDecoration(
        labelText: context.cityLabel,
        hintText: context.selectCity,
      ),
    );
  }

  Widget _areaDropdown(BuildContext context, AddAddressState state) {
    final hasCity = state.selectedCity != null;
    return DropdownButtonFormField<AreaItem>(
      isExpanded: true,
      initialValue: state.selectedArea,
      items: state.filteredAreas
          .map(
            (a) => DropdownMenuItem(
              value: a,
              child: Text(a.nameEn, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: !hasCity
          ? null
          : (area) {
              if (area != null) {
                context.read<AddAddressCubit>().doIntent(
                  AreaSelectedIntent(area),
                );
              }
            },
      decoration: InputDecoration(
        labelText: context.areaLabel,
        hintText: context.selectArea,
      ),
    );
  }
}
