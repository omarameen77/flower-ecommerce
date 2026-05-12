import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_tokens.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/category_item.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/section_title.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Categories',onViewAll: (){}),
            const SizedBox(height: 12),
            SizedBox(
              height: HomeTokens.categoryItemHeight,
              child: state.categoryBaseState.isLoading
                  ? _buildShimmer()
                  : state.categoryBaseState.data?.isEmpty ?? true
                  ? const SizedBox.shrink()
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categoryBaseState.data!.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: HomeTokens.sectionItemSpacing),
                      itemBuilder: (context, index) => CategoryItem(
                        category: state.categoryBaseState.data![index],
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.grey400,
      highlightColor: AppColors.grey200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) =>
            const SizedBox(width: HomeTokens.sectionItemSpacing),
        itemBuilder: (_, __) => Column(
          children: [
            Container(
              width: HomeTokens.widthCategoryIconBoxSize,
              height: HomeTokens.heightCategoryIconBoxSize,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 80,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
