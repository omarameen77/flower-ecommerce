import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/storage/secure_storage_service.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  bool _showBrand = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.90,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    _startSplashSequence();
  }

  Future<void> _startSplashSequence() async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      _showBrand = true;
    });

    await Future.delayed(const Duration(milliseconds: 1100));

    if (!mounted || _isNavigating) return;

    _isNavigating = true;

    await _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await SecureStorageService.getToken();

    final isLoggedIn = token != null && token.isNotEmpty;

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.appSections);
    } else {
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Decorations
          Positioned(
            top: -120,
            right: -100,
            child: _buildGlowCircle(size: 280, opacity: 0.08)
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .move(
                  begin: const Offset(0, 0),
                  end: const Offset(-15, 20),
                  duration: const Duration(seconds: 4),
                  curve: Curves.easeInOut,
                ),
          ),

          Positioned(
            bottom: -140,
            left: -110,
            child: _buildGlowCircle(size: 320, opacity: 0.06)
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .move(
                  begin: const Offset(0, 0),
                  end: const Offset(20, -15),
                  duration: const Duration(seconds: 5),
                  curve: Curves.easeInOut,
                ),
          ),

          Positioned(
            top: 150,
            left: -30,
            child: _buildGlowCircle(size: 90, opacity: 0.04)
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .move(
                  begin: const Offset(0, 0),
                  end: const Offset(12, 15),
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInOut,
                ),
          ),

          // Main Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Main Flower Logo Animation
                    SvgPicture.asset(
                          AppSvgs.splashLogo,
                          width: 125,
                          height: 125,
                          fit: BoxFit.contain,
                        )
                        .animate()
                        .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOut,
                        )
                        .slideY(
                          begin: 0.35,
                          end: 0,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                        )
                        .scale(
                          begin: const Offset(0.65, 0.65),
                          end: const Offset(1, 1),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                        ),

                    const SizedBox(height: 18),

                    // App Name
                    AnimatedOpacity(
                      opacity: _showBrand ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      child:
                          const Text(
                                'Flowery',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  color: AppColors.primary,
                                ),
                              )
                              .animate(target: _showBrand ? 1 : 0)
                              .fadeIn(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              )
                              .slideY(
                                begin: 0.3,
                                end: 0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutCubic,
                              )
                              .shimmer(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(milliseconds: 800),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowCircle({required double size, required double opacity}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: opacity),
      ),
    );
  }
}
