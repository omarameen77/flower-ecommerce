import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/features/product_sections/presentation/occasions/widgets/occasion_fallback_images.dart';
import 'package:flutter/material.dart';

class OccasionImage extends StatelessWidget {
  final String? imageUrl;
  final String? occasionName;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const OccasionImage({
    super.key,
    required this.imageUrl,
    required this.occasionName,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    final fallbackImage = OccasionFallbackImages.getImage(occasionName);

    final apiImage = imageUrl?.trim();

    final imageUrlToUse = apiImage != null && apiImage.isNotEmpty
        ? apiImage
        : fallbackImage;

    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrlToUse,
        width: width,
        height: height,
        fit: BoxFit.cover,

        placeholder: (context, url) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey.shade200,
          );
        },

        errorWidget: (context, url, error) {
          // لو صورة الـ API فشلت
          // نجرب صورة الـ fallback الخاصة بالـ occasion.
          if (imageUrlToUse != fallbackImage) {
            return CachedNetworkImage(
              imageUrl: fallbackImage,
              width: width,
              height: height,
              fit: BoxFit.cover,
              placeholder: (_, __) {
                return Container(
                  width: width,
                  height: height,
                  color: Colors.grey.shade200,
                );
              },
              errorWidget: (_, __, ___) {
                return Container(
                  width: width,
                  height: height,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.local_florist_outlined,
                    color: Colors.grey,
                  ),
                );
              },
            );
          }

          return Container(
            width: width,
            height: height,
            color: Colors.grey.shade300,
            child: const Icon(Icons.local_florist_outlined, color: Colors.grey),
          );
        },
      ),
    );
  }
}
