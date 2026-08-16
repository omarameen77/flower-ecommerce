import 'package:flutter/material.dart';

enum SearchTransitionType { category, home }

abstract class PageTransitions {
  static PageRoute<dynamic> fade(Widget page) => PageRouteBuilder<dynamic>(
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, animation, _, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 300),
  );

  static PageRoute<dynamic> slide(Widget page) => PageRouteBuilder<dynamic>(
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, animation, _, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 350),
  );

  static PageRoute<dynamic> search(
    Widget page, {
    SearchTransitionType type = SearchTransitionType.category,
  }) {
    switch (type) {
      case SearchTransitionType.category:
        return _categorySearch(page);

      case SearchTransitionType.home:
        return _homeSearch(page);
    }
  }

  // Category → Search
  static PageRoute<dynamic> _categorySearch(Widget page) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (_, _, _) => page,

      transitionDuration: const Duration(milliseconds: 450),
      reverseTransitionDuration: const Duration(milliseconds: 300),

      transitionsBuilder: (_, animation, _, child) {
        final fade = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );

        final scale = Tween<double>(begin: 0.98, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

        return FadeTransition(
          opacity: fade,
          child: ScaleTransition(scale: scale, child: child),
        );
      },
    );
  }

  // Home → Search
  static PageRoute<dynamic> _homeSearch(Widget page) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (_, _, _) => page,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 1),
      transitionsBuilder: (_, animation, _, child) {
        if (animation.status == AnimationStatus.reverse) {
          return child;
        }
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
