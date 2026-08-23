import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/localization_constants/layout_constants.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/cart/presentation/pages/cart_screen.dart';
import 'package:flower/features/product_sections/presentation/categories/pages/categories_screen.dart';
import 'package:flower/features/product_sections/presentation/home/pages/home_screen.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_event.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/occasion_cubit/occasion_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/occasion_cubit/occasion_event.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flower/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../cubit/app_sections_cubit.dart';

class AppSectionsPage extends StatelessWidget {
  const AppSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppSectionsCubit()),

        BlocProvider.value(
          value: getIt<CategoriesCubit>()..onEvent(GetCategoriesEvent()),
        ),

        BlocProvider(
          create: (_) => getIt<ProductCubit>()..doEvent(GetProductEvent()),
        ),

        BlocProvider.value(
          value: getIt<OccasionCubit>()..doEvent(const GetOccasionsEvent()),
        ),
      ],
      child: const _AppSectionsView(),
    );
  }
}

class _AppSectionsView extends StatelessWidget {
  const _AppSectionsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSectionsCubit, AppSectionsState>(
      builder: (context, state) {
        final cubit = context.read<AppSectionsCubit>();

        final currentIndex = state is AppSectionsChanged
            ? state.currentIndex
            : 0;

        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: [
              const HomeScreen(),
              const CategoryScreen(),
              const CartScreen(),
              ProfilePage(),
            ],
          ),

          bottomNavigationBar: _buildBottomNavigationBar(
            context,
            currentIndex,
            cubit,
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    int currentIndex,
    AppSectionsCubit cubit,
  ) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: cubit.changeSection,

            backgroundColor: AppColors.background,

            color: AppColors.grey700,

            activeColor: AppColors.primary,

            tabBackgroundColor: AppColors.primary.withOpacity(0.10),

            gap: 6,

            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

            duration: const Duration(milliseconds: 300),

            curve: Curves.easeOutCubic,

            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: LayoutConstants.homeTab,
                leading: _buildNavIcon(AppSvgs.home, currentIndex == 0),
              ),

              GButton(
                icon: Icons.category_outlined,
                text: LayoutConstants.categoriesTab,
                leading: _buildNavIcon(AppSvgs.category, currentIndex == 1),
              ),

              GButton(
                icon: Icons.shopping_cart_outlined,
                text: LayoutConstants.cartTab,
                leading: _buildNavIcon(AppSvgs.cart, currentIndex == 2),
              ),

              GButton(
                icon: Icons.person_outline,
                text: LayoutConstants.profileTab,
                leading: _buildNavIcon(AppSvgs.profile, currentIndex == 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(String icon, bool isSelected) {
    return SvgPicture.asset(
      icon,
      width: 21,
      height: 21,
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.primary : AppColors.grey700,
        BlendMode.srcIn,
      ),
    );
  }
}
