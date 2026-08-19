import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderCardShimmer extends StatelessWidget {
  const OrderCardShimmer({super.key});

  Widget _box({
    required double width,
    required double height,
    double radius = 6,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            _box(width: 100, height: 105, radius: 12),

            const SizedBox(width: 12),

            Expanded(
              child: SizedBox(
                height: 105,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    _box(width: 130, height: 13),

                    const SizedBox(height: 8),

                    // Price
                    _box(width: 75, height: 18),

                    const SizedBox(height: 7),

                    // Order number
                    _box(width: 105, height: 11),

                    const Spacer(),

                    // Button
                    _box(width: double.infinity, height: 32, radius: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
