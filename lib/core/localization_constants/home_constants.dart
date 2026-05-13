import 'package:easy_localization/easy_localization.dart';

abstract class HomeConstants {
  const HomeConstants._();

  static String get search => "home.search".tr();
  static String get searchHint => "home.searchHint".tr();
  static String get notFound => "home.product_not_found".tr();
  static String get all => "home.all".tr();
  static String get searching => "home.searching".tr();
}
