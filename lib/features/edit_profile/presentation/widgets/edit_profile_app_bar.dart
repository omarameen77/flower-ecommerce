import 'package:flower/core/localization_constants/edit_profile_constants.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class EditProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EditProfileConstants.title,
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
