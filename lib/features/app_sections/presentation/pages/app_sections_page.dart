import 'package:flower/core/localization_constants/layout_constants.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/product_sections/presentation/home/pages/home_screen.dart';
import 'package:flower/features/profile/presentation/prorile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cubit/app_sections_cubit.dart';

class AppSectionsPage extends StatelessWidget {
  const AppSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppSectionsCubit(),
      child: const _AppSectionsView(),
    );
  }
}

class _AppSectionsView extends StatelessWidget {
  const _AppSectionsView();

  List<_BottomNavItem> _items(BuildContext context) {
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
              HomeScreen(),
              _PlaceholderScreen(title: LayoutConstants.categoriesTab),
              _PlaceholderScreen(title: LayoutConstants.cartTab),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: cubit.changeSection,
            items: _items(context).map((item) {
              return BottomNavigationBarItem(
                label: item.label,
                icon: _NavBarIcon(assetName: item.icon, isSelected: false),
                activeIcon: _NavBarIcon(assetName: item.icon, isSelected: true),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final String assetName;
  final bool isSelected;

  const _NavBarIcon({required this.assetName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(
      context,
    ).bottomNavigationBarTheme.selectedItemColor;

    final unselectedColor = Theme.of(
      context,
    ).bottomNavigationBarTheme.unselectedItemColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SvgPicture.asset(
        assetName,
        colorFilter: ColorFilter.mode(
          isSelected
              ? (selectedColor ?? Theme.of(context).primaryColor)
              : (unselectedColor ?? AppColors.grey700),
          BlendMode.srcIn,
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

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
