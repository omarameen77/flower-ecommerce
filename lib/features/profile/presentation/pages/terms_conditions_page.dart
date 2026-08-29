import 'package:flower/core/localization_constants/profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionsPage extends StatefulWidget {
  const TermsConditionsPage({super.key});

  @override
  State<TermsConditionsPage> createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setBackgroundColor(AppColors.background)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://elevate-flutter-team.github.io/flower_app_web_views/terms.html',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: ProfileConstants.termsConditions,
        color: AppColors.grey100,
      ),
      body: Stack(children: [WebViewWidget(controller: _controller)]),
    );
  }
}
