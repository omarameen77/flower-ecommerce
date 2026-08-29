import 'package:easy_localization/easy_localization.dart';

abstract class HomeConstants {
  const HomeConstants._();

  static String get search => "home.search".tr();
  static String get searchHint => "home.searchHint".tr();
  static String get notFound => "home.product_not_found".tr();
  static String get all => "home.all".tr();
  static String get searching => "home.searching".tr();
  static String get sortBy => "home.sort_by".tr();
  static String get lowestPrice => "home.lowest_price".tr();
  static String get highestPrice => "home.highest_price".tr();
  static String get newest => "home.new".tr();
  static String get oldest => "home.old".tr();
  static String get discount => "home.discount".tr();
  static String get filter => "home.filter".tr();
  static String get productloading => "loading...";
  static String get occasion => "home.occasion".tr();
  static String get occasionSubtitle => "home.occasion_subtitle".tr();
  static String get bestSeller => "home.best_seller".tr();
  static String get bestSellerSubtitle => "home.best_seller_subtitle".tr();
}
