import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String url;
  final String? successUrl;
  final String? cancelUrl;

  const PaymentWebViewPage({
    super.key,
    required this.url,
    this.successUrl,
    this.cancelUrl,
  });

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController _controller;

  bool _isLoading = true;
  bool _initialPageLoaded = false;
  bool _completed = false;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (!_initialPageLoaded && mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (_) {
            if (mounted) {
              setState(() {
                _initialPageLoaded = true;
                _isLoading = false;
              });
            }
          },
          onNavigationRequest: (request) {
            if (_completed) {
              return NavigationDecision.prevent;
            }

            final successUrl = widget.successUrl;
            if (successUrl != null &&
                successUrl.isNotEmpty &&
                request.url.startsWith(successUrl)) {
              _completed = true;
              Navigator.of(context).pop(true);
              return NavigationDecision.prevent;
            }

            final cancelUrl = widget.cancelUrl;
            if (cancelUrl != null &&
                cancelUrl.isNotEmpty &&
                request.url.startsWith(cancelUrl)) {
              _completed = true;
              Navigator.of(context).pop(false);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: CheckoutConstants.paymentMethod),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          // Only show the skeleton while the payment page
          // is loading for the first time.
          if (_isLoading && !_initialPageLoaded)
            const Positioned.fill(child: PaymentLoadingSkeleton()),

          // For later navigations, don't hide the payment page.
          // Just show a small loading indicator.
          if (_isLoading && _initialPageLoaded)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(minHeight: 2),
            ),
        ],
      ),
    );
  }
}

class PaymentLoadingSkeleton extends StatelessWidget {
  const PaymentLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                ImageShimmer(
                  width: 30,
                  height: 30,
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                ),
                const SizedBox(width: 10),
                ImageShimmer(
                  width: 68,
                  height: 30,
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                ),
              ],
            ),

            const SizedBox(height: 35),

            // Customer name
            Center(
              child: ImageShimmer(
                width: 45,
                height: 18,
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
              ),
            ),

            const SizedBox(height: 8),

            // Amount
            Center(
              child: ImageShimmer(
                width: 145,
                height: 35,
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
              ),
            ),

            const SizedBox(height: 55),

            // Email card
            _SkeletonBox(
              height: 58,
              child: Row(
                children: [
                  ImageShimmer(
                    width: 45,
                    height: 15,
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                  const SizedBox(width: 70),
                  Expanded(
                    child: ImageShimmer(
                      width: double.infinity,
                      height: 15,
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Payment method title
            ImageShimmer(
              width: 135,
              height: 20,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            ),

            const SizedBox(height: 18),

            // Payment form
            _SkeletonBox(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageShimmer(
                    width: 80,
                    height: 18,
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),

                  const SizedBox(height: 22),

                  ImageShimmer(
                    width: 105,
                    height: 14,
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),

                  const SizedBox(height: 8),

                  // Card number
                  _InputSkeleton(height: 52),

                  const SizedBox(height: 14),

                  // MM / YY + CVC
                  Row(
                    children: [
                      Expanded(child: _InputSkeleton(height: 52)),
                      const SizedBox(width: 1),
                      Expanded(child: _InputSkeleton(height: 52)),
                    ],
                  ),

                  const SizedBox(height: 22),

                  ImageShimmer(
                    width: 120,
                    height: 14,
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),

                  const SizedBox(height: 8),

                  _InputSkeleton(height: 52),

                  const SizedBox(height: 22),

                  ImageShimmer(
                    width: 105,
                    height: 14,
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),

                  const SizedBox(height: 8),

                  _InputSkeleton(height: 52),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Save information
            _SkeletonBox(
              height: 90,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageShimmer(
                    width: 20,
                    height: 20,
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageShimmer(
                          width: 190,
                          height: 15,
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                        ),
                        const SizedBox(height: 10),
                        ImageShimmer(
                          width: double.infinity,
                          height: 12,
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                        ),
                        const SizedBox(height: 6),
                        ImageShimmer(
                          width: 130,
                          height: 12,
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const _SkeletonBox({
    this.height,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InputSkeleton extends StatelessWidget {
  final double height;

  const _InputSkeleton({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ImageShimmer(
          width: 100,
          height: 15,
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        ),
      ),
    );
  }
}
