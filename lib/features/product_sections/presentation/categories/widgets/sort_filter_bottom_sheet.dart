import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/home_constants.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/button_with_prefix.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SortOption {
  final String label;
  final String value;
  const SortOption(this.label, this.value);
}

List<SortOption> _options() => [
  SortOption(HomeConstants.lowestPrice, 'priceAfterDiscount'),
  SortOption(HomeConstants.highestPrice, '-priceAfterDiscount'),
  SortOption(HomeConstants.newest, '-createdAt'),
  SortOption(HomeConstants.oldest, 'createdAt'),
  SortOption(HomeConstants.discount, '-discount'),
];

Future<void> showSortFilterSheet(
  BuildContext context, {
  required String? activeCategoryId,
}) {
  final productCubit = context.read<ProductCubit>();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => BlocProvider.value(
      value: productCubit,
      child: _SortFilterSheet(activeCategoryId: activeCategoryId),
    ),
  );
}

class _SortFilterSheet extends StatefulWidget {
  final String? activeCategoryId;
  const _SortFilterSheet({required this.activeCategoryId});

  @override
  State<_SortFilterSheet> createState() => _SortFilterSheetState();
}

class _SortFilterSheetState extends State<_SortFilterSheet> {
  late String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = context.read<ProductCubit>().state.currentSort;
  }

  void _apply() {
    context.read<ProductCubit>().doEvent(
      GetProductEvent(
        sort: _selected,
        categoryId: widget.activeCategoryId,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final options = _options();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HomeConstants.sortBy,
              style: getSemiBoldStyle(
                context: context,
                color: AppColors.primary,
                fontSize: FontSizeManager.s18,
              ),
            ),
            const AppSizedBox(height: AppSize.s12),
            ...options.map(
              (o) => _SortRow(
                option: o,
                selected: _selected == o.value,
                onTap: () => setState(() => _selected = o.value),
              ),
            ),
            const AppSizedBox(height: AppSize.s16),
            ButtonWithPrefix(
              text: HomeConstants.filter,
              onTap: _apply,
              prefixIcon: SvgPicture.asset(
                AppSvgs.filterButton,
                width: AppSize.s20,
                height: AppSize.s20,
              ),
            ),
            const AppSizedBox(height: AppSize.s8),
          ],
        ),
      ),
    );
  }
}

class _SortRow extends StatelessWidget {
  final SortOption option;
  final bool selected;
  final VoidCallback onTap;

  const _SortRow({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s12),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppSize.s16,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : const [],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option.label,
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.textPrimary,
                    fontSize: FontSizeManager.s14,
                  ),
                ),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: AppColors.primary,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
