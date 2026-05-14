import 'package:flower/features/profile/presentation/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
    this.horizontalPadding = 20,
  });

  final double horizontalPadding;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: horizontalPadding,
      title: const AppLogoWidget(),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: Badge(
            child: IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
