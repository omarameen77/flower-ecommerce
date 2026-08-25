import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/home_constants.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_token.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/horizontal_products_list.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/section_title.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellersSection extends StatelessWidget {
  const BestSellersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: HomeTokens.horizontalPadding,
              ),
              child: SectionTitle(
                title: HomeConstants.bestSeller,
                onViewAll: () =>
                    Navigator.pushNamed(context, Routes.bestSellers),
              ),
            ),
            const AppSizedBox(height: 12),
            HorizontalProductsList(
              products: state.productBaseState.data,
              isLoading: state.productBaseState.isLoading,
            ),
          ],
        );
      },
    );
  }
}
