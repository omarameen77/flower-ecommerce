import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/localization_constants/home_constants.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/features/product_sections/presentation/best_sellers/widgets/best_sellers_grid.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellersPage extends StatelessWidget {
  const BestSellersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ProductCubit>()..doEvent(const GetProductEvent(sort: '-sold')),
      child: Scaffold(
        appBar: CustomAppBar(
          title: HomeConstants.bestSeller,
          subtitle: HomeConstants.bestSellerSubtitle,
        ),
        body: const BestSellersGrid(),
      ),
    );
  }
}
