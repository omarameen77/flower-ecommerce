import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flower/config/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    _controller.forward();

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () async {
          if (!mounted) return;

          final token = await SecureStorageService.getToken();

          if (token != null && token.isNotEmpty) {
            Navigator.of(context)
                .pushReplacementNamed(Routes.appSections);
          } else {
            Navigator.of(context)
                .pushReplacementNamed(Routes.login);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: SvgPicture.asset(
            AppSvgs.splashLogo,
            width: 180,
            height: 180,
          ),
        ),
      ),
    );
  }
}