import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String urlToImage;
  final double? height;
  final double? width;

  const CachedNetworkImageWidget({
    super.key,
    required this.urlToImage,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? AppSize.s60,
      memCacheHeight: 400,
      width: width ?? AppSize.s60,
      imageUrl: urlToImage,
      fit: BoxFit.cover,
      placeholder: (context, url) => ImageShimmer(
        width: width ?? AppSize.s50,
        height: height ?? AppSize.s50,
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: Colors.red,
        size: AppSize.s24,
      ),
    );
  }
}

