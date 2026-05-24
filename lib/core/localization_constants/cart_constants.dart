import 'package:easy_localization/easy_localization.dart';

abstract class CartConstants {
  CartConstants._();

  static String get cart => "cart.cart".tr();

  static String get emptyCart => "cart.empty_cart".tr();

  static String get checkOut => "cart.checkout".tr();

  static const String staticLocation = '2XVP+XC - Sheikh Zayed.....';

  static String get deliveringTo => 'cart.delivery'.tr();

  static String get total => "cart.total".tr();

  static String get subTotal => "cart.subtotal".tr();

  static String get delivery => "cart.delivery".tr();

  static String get goShopping => "cart.go_shopping".tr();

  static String get egp => "cart.egp".tr();

  static String get items => "cart.items".tr();

  static String get alreadyAdded => "cart.already_added".tr();
  static const String empty = '';
}
