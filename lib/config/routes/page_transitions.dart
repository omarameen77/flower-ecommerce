import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum SearchTransitionType { category, home }

/// Every route is built once by [Navigator] and is not rebuilt just because
/// an ancestor (like `MaterialApp`) rebuilds with a new `locale` — screens
/// only pick up translated text again if something else happens to rebuild
/// them. Reading [context.locale] here subscribes this wrapper to
/// `EasyLocalization`'s `InheritedWidget`, so switching languages marks it
/// dirty; giving the subtree a new [ValueKey] then forces that page (and
/// everything inside it, including screens sitting inactive in the
/// navigation stack) to be rebuilt from scratch with the new language,
/// without resetting the navigation stack itself.
class _LocaleAwarePage extends StatelessWidget {
  const _LocaleAwarePage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: ValueKey(context.locale), child: child);
  }
}

abstract class PageTransitions {
  static PageRoute<dynamic> fade(Widget page) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (_, _, _) => _LocaleAwarePage(child: page),
      transitionDuration: const Duration(milliseconds: 450),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        final scaleAnimation = Tween<double>(
          begin: 0.985,
          end: 1.0,
        ).animate(curvedAnimation);

        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(scale: scaleAnimation, child: child),
        );
      },
    );
  }

  static PageRoute<dynamic> slide(Widget page) => PageRouteBuilder<dynamic>(
    pageBuilder: (_, _, _) => _LocaleAwarePage(child: page),
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
      pageBuilder: (_, _, _) => _LocaleAwarePage(child: page),

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
      pageBuilder: (_, _, _) => _LocaleAwarePage(child: page),
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
