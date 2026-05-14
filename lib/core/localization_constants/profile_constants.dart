import 'package:easy_localization/easy_localization.dart';

abstract class ProfileConstants {
  ProfileConstants._();

  static String get myOrders => 'profile.my_orders'.tr();
  static String get savedAddress => 'profile.saved_address'.tr();
  static String get notifications => 'profile.notifications'.tr();
  static String get language => 'profile.language'.tr();
  static String get english => 'profile.english'.tr();
  static String get arabic => 'profile.arabic'.tr();
  static String get aboutUs => 'profile.about_us'.tr();
  static String get termsConditions => 'profile.terms_conditions'.tr();
  static String get logout => 'profile.logout'.tr();
  static String get logoutTitle => 'profile.logout_title'.tr();
  static String get logoutMessage => 'profile.logout_message'.tr();
  static String get cancel => 'profile.cancel'.tr();
  static String get version => 'profile.version'.tr();
}
