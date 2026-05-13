import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/presentation/occasions/cubit/occasions_products_cubit.dart';
import 'package:flower/features/product_sections/presentation/occasions/widgets/products_grid_by_occasion.dart';

class OccasionTabsView extends StatelessWidget {
  final List<OccasionEntity> occasions;
  final ScrollController scrollController;

  const OccasionTabsView({
    super.key,
    required this.occasions,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final initialIndex = context
        .read<OccasionsProductsCubit>()
        .state
        .selectedOccasionIndex;

    return DefaultTabController(
      length: occasions.length,
      initialIndex: initialIndex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: getMediumStyle(
              context: context,
              color: AppColors.primary,
              fontSize: 14,
            ),
            unselectedLabelStyle: getRegularStyle(
              context: context,
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
            dividerColor: AppColors.border,
            tabAlignment: TabAlignment.start,
            onTap: (index) => context.read<OccasionsProductsCubit>().doEvent(
              SelectOccasionEvent(index),
            ),
            tabs: occasions.map((occasion) {
              return Tab(text: occasion.name ?? 'Unknown');
            }).toList(),
          ),
          const AppSizedBox(height: 8),
          Expanded(
            child: TabBarView(
              children: occasions.map((occasion) {
                return ProductsGridByOccasion(
                  occasionId: occasion.id ?? '',
                  scrollController: scrollController,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
