import 'package:flower/config/routes/page_transitions.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/home_constants.dart';
import 'package:flower/core/resources/app_strings.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_search_text_field.dart';
import 'package:flower/features/product_sections/domain/entities/category_entity.dart';
import 'package:flower/features/product_sections/presentation/categories/widgets/linear_indicator_widget.dart';
import 'package:flower/features/product_sections/presentation/categories/widgets/sliver_tab_bar_delegate.dart';
import 'package:flower/features/product_sections/presentation/categories/widgets/sort_filter_bottom_sheet.dart';
import 'package:flower/features/product_sections/presentation/categories/widgets/view_product_widget.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_event.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final originalCategories = state.categoriesState.data?.categories ?? [];
        final categories = [
          CategoryEntity(name: HomeConstants.all, id: null),
          ...originalCategories,
        ];

        // `selectedCategoryIndex` lives in a shared cubit and can outlive the
        // category list it was chosen from (e.g. after navigating away and
        // back while the list reloads with fewer entries), so it must always
        // be re-validated against the current `categories.length` before use.
        final selectedIndex = state.selectedCategoryIndex.clamp(
          0,
          categories.length - 1,
        );

        if (_tabController == null ||
            _tabController!.length != categories.length) {
          _tabController?.dispose();

          _tabController = TabController(
            length: categories.length,
            vsync: this,
            initialIndex: selectedIndex,
          );

          _tabController!.addListener(() {
            if (_tabController!.indexIsChanging) {
              final index = _tabController!.index;

              context.read<CategoriesCubit>().onEvent(
                ChangeSelectedCategoryEvent(index),
              );

              context.read<ProductCubit>().doEvent(
                GetProductEvent(categoryId: categories[index].id),
              );
            }
          });
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_tabController?.index != selectedIndex) {
            _tabController?.animateTo(selectedIndex);
          }
        });

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    floating: true,
                    snap: true,
                    elevation: 0,
                    toolbarHeight: 80,
                    backgroundColor: AppColors.background,
                    surfaceTintColor: AppColors.background,
                    title: Row(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: AppStrings.searchFieldHeroTag,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.searchScreen,
                                    arguments: {
                                      'productCubit': context
                                          .read<ProductCubit>(),
                                      'transitionType':
                                          SearchTransitionType.category,
                                    },
                                  );
                                },
                                child: IgnorePointer(
                                  child: CustomSearchTextField(
                                    hint: HomeConstants.search,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const AppSizedBox(width: 10),
                        _buildFilterButton(
                          context,
                          categories[selectedIndex].id,
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverTabBarDelegate(
                      child: Container(
                        color: AppColors.background,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TabBar(
                              controller: _tabController,
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              dividerColor: AppColors.transparent,
                              indicatorColor:
                                  context
                                      .watch<ProductCubit>()
                                      .state
                                      .productBaseState
                                      .isLoading
                                  ? AppColors.transparent
                                  : AppColors.primary,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: AppColors.primary,
                              unselectedLabelColor: AppColors.grey700,
                              tabs: categories
                                  .map(
                                    (cat) => Tab(text: cat.name ?? "notfound"),
                                  )
                                  .toList(),
                            ),
                            BlocBuilder<ProductCubit, ProductState>(
                              builder: (context, productState) {
                                return SizedBox(
                                  height: 4,
                                  child: productState.productBaseState.isLoading
                                      ? LinearIndicatorWidget(
                                          productState: productState
                                              .productBaseState
                                              .isLoading,
                                        )
                                      : const SizedBox.shrink(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: ViewProductWidget(
                categories: categories,
                tabController: _tabController!,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterButton(BuildContext context, String? activeCategoryId) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          showSortFilterSheet(context, activeCategoryId: activeCategoryId),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.background.withOpacity(0.65),
          border: Border.all(
            color: AppColors.grey900.withOpacity(0.25),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          Icons.filter_list_rounded,
          size: 22,
          color: AppColors.grey700,
        ),
      ),
    );
  }
}
