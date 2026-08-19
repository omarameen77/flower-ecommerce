import 'dart:ui';

import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/localization_constants/layout_constants.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
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

  List<_BottomNavItem> _items() {
    return [
      _BottomNavItem(label: LayoutConstants.homeTab, icon: AppSvgs.home),
      _BottomNavItem(
        label: LayoutConstants.categoriesTab,
        icon: AppSvgs.category,
      ),
      _BottomNavItem(label: LayoutConstants.cartTab, icon: AppSvgs.cart),
      _BottomNavItem(label: LayoutConstants.profileTab, icon: AppSvgs.profile),
    ];
  }

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

          bottomNavigationBar: _GlassBottomNavigationBar(
            currentIndex: currentIndex,
            items: _items(),
            onTap: cubit.changeSection,
          ),
        );
      },
    );
  }
}

class _GlassBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<_BottomNavItem> items;
  final ValueChanged<int> onTap;

  const _GlassBottomNavigationBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: SafeArea(
        top: false,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 18),
            child: Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.90),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.07),
                    blurRadius: 18,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: List.generate(items.length, (index) {
                  return Flexible(
                    child: _NavBarItem(
                      item: items[index],
                      isSelected: currentIndex == index,
                      onTap: () => onTap(index),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final _BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.05 : 1,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: SvgPicture.asset(
                  item.icon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.primary : AppColors.grey700,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              if (isSelected) ...[
                const SizedBox(width: 6),

                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getMediumStyle(
                    context: context,
                    fontSize: 10.5,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem {
  final String label;
  final String icon;

  const _BottomNavItem({required this.label, required this.icon});
}
