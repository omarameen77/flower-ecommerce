import 'package:easy_localization/easy_localization.dart';

abstract class OrdersConstants {
  OrdersConstants._();

  static String get myOrders => 'orders.my_orders'.tr();
  static String get active => 'orders.active'.tr();
  static String get completed => 'orders.completed'.tr();
  static String get noActiveOrders => 'orders.no_active_orders'.tr();
  static String get noCompletedOrders => 'orders.no_completed_orders'.tr();
  static String get orderNumber => 'orders.order_number'.tr();
  static String get trackOrder => 'orders.track_order'.tr();
}
