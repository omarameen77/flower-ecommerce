import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_tokens.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/best_sellers_section.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/categories_section.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/home_header.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/location_widget.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/occasions_section.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/category_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/category_event.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/occasion_cubit/occasion_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/occasion_cubit/occasion_event.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProductCubit>()
            ..setSort('-sold')
            ..doEvent(const GetProductEvent()),
        ),
        BlocProvider(
          create: (_) =>
              getIt<CategoryCubit>()..doEvent(const GetCategoriesEvent()),
        ),
        BlocProvider(
          create: (_) =>
              getIt<OccasionCubit>()..doEvent(const GetOccasionsEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: HomeTokens.horizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 12),
                HomeHeader(),
               AppSizedBox(height: AppSize.s16),
                LocationWidget(),
                AppSizedBox(height:AppSize.s24),
                CategoriesSection(),
                AppSizedBox(height: AppSize.s24),
                BestSellersSection(),
                AppSizedBox(height: AppSize.s24),
                OccasionsSection(),
                AppSizedBox(height: AppSize.s24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
