import 'package:flower/config/base/base_state.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/localization_constants/categories_constants.dart';
import 'package:flower/core/widgets/app_loading_widget.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/features/product_sections/domain/entities/category_entity.dart';
import 'package:flower/features/product_sections/presentation/categories/cubit/category_products_cubit.dart';
import 'package:flower/features/product_sections/presentation/categories/widgets/category_error_view.dart';
import 'package:flower/features/product_sections/presentation/categories/widgets/category_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  late final CategoryProductsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<CategoryProductsCubit>()
      ..doEvent(const LoadInitialDataEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _cubit.doEvent(HandleScrollEvent(_scrollController));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: CategoriesConstants.title,
          subtitle: CategoriesConstants.subtitle,
          showBackButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: BlocSelector<
            CategoryProductsCubit,
            CategoryProductsState,
            BaseState<List<CategoryEntity>>
          >(
            selector: (state) => state.categoriesState,
            builder: (context, categoryState) {
              final categories = categoryState.data ?? [];

              if (categoryState.isLoading && categories.isEmpty) {
                return const AppLoadingWidget();
              }

              if (categoryState.errorMessage != null && categories.isEmpty) {
                return CategoryErrorView(
                  message: categoryState.errorMessage!,
                  onRetry: () => context
                      .read<CategoryProductsCubit>()
                      .doEvent(RetryEvent()),
                );
              }

              if (categories.isEmpty) {
                return Center(
                  child: Text(CategoriesConstants.noCategoriesFound),
                );
              }

              return CategoryTabsView(
                categories: categories,
                scrollController: _scrollController,
              );
            },
          ),
        ),
      ),
    );
  }
}
