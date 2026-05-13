import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String urlToImage;
  const CachedNetworkImageWidget({super.key, required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: AppSize.s60,
      memCacheHeight: 400,
      width: AppSize.s60,
      imageUrl: urlToImage,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          ImageShimmer(width: AppSize.s50, height: AppSize.s50),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red, size: AppSize.s24),
    );
  }
}
