import 'package:easy_localization/easy_localization.dart';

abstract class OrdersConstants {
  OrdersConstants._();

  static String get myOrders => 'orders.my_orders'.tr();
  static String get pending => 'orders.pending'.tr();
  static String get inProgress => 'orders.in_progress'.tr();
  static String get canceled => 'orders.canceled'.tr();
  static String get completed => 'orders.completed'.tr();
  static String get noPendingOrders => 'orders.no_pending_orders'.tr();
  static String get noInProgressOrders => 'orders.no_in_progress_orders'.tr();
  static String get noCanceledOrders => 'orders.no_canceled_orders'.tr();
  static String get noCompletedOrders => 'orders.no_completed_orders'.tr();
  static String get orderNumber => 'orders.order_number'.tr();
  static String get trackOrder => 'orders.track_order'.tr();
}
