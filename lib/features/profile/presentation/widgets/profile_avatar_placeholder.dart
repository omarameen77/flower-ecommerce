import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatarPlaceholder extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;

  const ProfileAvatarPlaceholder({
    super.key,
    this.imageUrl,
    this.width = 88,
    this.height = 88,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImageWidget(
          urlToImage: imageUrl!,
          width: width,
          height: height,
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.grey200,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.person, size: width * 0.45, color: Colors.black),
      ),
    );
  }
}

