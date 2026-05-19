import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_token.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/occasion_item_shimmer.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/section_title.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/occasion_cubit/occasion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionsSection extends StatelessWidget {
  const OccasionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionCubit, OccasionState>(
      builder: (context, state) {
        const listHeight = HomeTokens.occasionCardImageHeight + 36;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: 'Occasion',
              onViewAll: () => Navigator.pushNamed(context, Routes.occasions),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: listHeight,
              child: state.occasionBaseState.isLoading
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: HomeTokens.sectionItemSpacing),
                      itemBuilder: (_, _) => const OccasionItemShimmer(),
                    )
                  : state.occasionBaseState.data?.isEmpty ?? true
                  ? const SizedBox.shrink()
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.occasionBaseState.data!.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: HomeTokens.sectionItemSpacing),
                      itemBuilder: (_, index) {
                        final occasion = state.occasionBaseState.data![index];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.occasions,
                            arguments: occasion.id,
                          ),
                          child: SizedBox(
                            width: HomeTokens.occasionCardWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: occasion.image ?? '',
                                    width: HomeTokens.occasionCardWidth,
                                    height: HomeTokens.occasionCardImageHeight,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(color: AppColors.grey400),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          color: AppColors.grey400,
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: AppColors.grey700,
                                          ),
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  occasion.name ?? '',
                                  style: getRegularStyle(
                                    context: context,
                                    fontSize: FontSizeManager.s14,
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
