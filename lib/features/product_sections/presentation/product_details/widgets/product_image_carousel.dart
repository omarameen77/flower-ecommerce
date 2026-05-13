import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;

  const ProductImageCarousel({
    super.key,
    required this.images,
    this.height = 320,
  });

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const ColoredBox(
          color: AppColors.grey500,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.grey800,
              size: 48,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => CachedNetworkImage(
              imageUrl: widget.images[i],
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => const ColoredBox(
                color: AppColors.grey500,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.grey800,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSize.s12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, _buildDot),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int i) {
    final selected = i == _index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: selected ? 12 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.grey600,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
