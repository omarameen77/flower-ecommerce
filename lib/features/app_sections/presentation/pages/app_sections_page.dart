import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../cubit/app_sections_cubit.dart';

class AppSectionsPage extends StatelessWidget {
  const AppSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSectionsCubit(),
      child: const _AppSectionsView(),
    );
  }
}

class _AppSectionsView extends StatelessWidget {
  const _AppSectionsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppSectionsCubit>();
    return BlocBuilder<AppSectionsCubit, AppSectionsState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: cubit.currentIndex,
            children: const [
              _PlaceholderScreen(title: 'Home'),
              _PlaceholderScreen(title: 'Categories'),
              _PlaceholderScreen(title: 'Cart'),
              _PlaceholderScreen(title: 'Profile'),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: cubit.changeSection,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset('assets/svgs/home.svg', colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset('assets/svgs/home.svg', colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset('assets/svgs/category.svg', colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset('assets/svgs/category.svg', colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset('assets/svgs/shopping_cart.svg', colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset('assets/svgs/shopping_cart.svg', colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset('assets/svgs/profile.svg', colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset('assets/svgs/profile.svg', colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
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
