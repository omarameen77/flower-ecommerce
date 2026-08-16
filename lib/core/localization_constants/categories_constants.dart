import 'package:easy_localization/easy_localization.dart';

abstract class CategoriesConstants {
  const CategoriesConstants._();

  static String get title => "categories.title".tr();
  static String get subtitle => "categories.subtitle".tr();
  static String get noCategoriesFound => "categories.no_categories_found".tr();
  static String get noProductsForCategory => "categories.no_products_for_category".tr();
}
