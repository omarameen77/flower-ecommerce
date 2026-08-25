import 'package:easy_localization/easy_localization.dart';

abstract class ProductDetailsConstants {
  const ProductDetailsConstants._();

  static String get notFound => "product_details.not_found".tr();
  static String get description => "product_details.description".tr();
  static String get allPricesIncludeTax =>
      "product_details.all_prices_include_tax".tr();
  static String get inStock => "product_details.in_stock".tr();
  static String get outOfStock => "product_details.out_of_stock".tr();
  static String get statusLabel => "product_details.status_label".tr();
}
