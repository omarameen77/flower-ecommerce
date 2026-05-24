import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String urlToImage;
  final double width;
  final double height;
  const CachedNetworkImageWidget({
    super.key,
    required this.urlToImage,
    this.width = AppSize.s60,
    this.height = AppSize.s60,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      memCacheHeight: 400,
      width: width,
      imageUrl: urlToImage,
      fit: BoxFit.cover,
      placeholder: (context, url) => ImageShimmer(width: width, height: height),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red, size: AppSize.s24),
    );
  }
}
