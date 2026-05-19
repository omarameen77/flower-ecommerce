 
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_token.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/best_sellers_section.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/categories_section.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/home_header.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/location_widget.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/occasions_section.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_event.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: HomeTokens.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const HomeHeader(),
              const AppSizedBox(height: AppSize.s16),
              const LocationWidget(),
              const AppSizedBox(height: AppSize.s24),
              const CategoriesSection(),
              const AppSizedBox(height: AppSize.s24),
              BlocProvider(
                create: (_) => getIt<ProductCubit>()
                  ..setSort('-sold')
                  ..doEvent(const GetProductEvent()),
                child: const BestSellersSection(),
              ),
              const AppSizedBox(height: AppSize.s24),
              const OccasionsSection(),
              const AppSizedBox(height: AppSize.s24),
            ],
          ),
        ),
      ),
    );
  }
}