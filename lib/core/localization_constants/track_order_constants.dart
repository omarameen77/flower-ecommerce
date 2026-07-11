import 'package:easy_localization/easy_localization.dart';

abstract class TrackOrderConstants {
  TrackOrderConstants._();

  static String get trackOrder => 'track_order.track_order'.tr();
  static String get orderConfirmed => 'track_order.order_confirmed'.tr();
  static String get orderNotFound => 'track_order.order_not_found'.tr();
  static String get orderDelivered => 'track_order.order_delivered'.tr();
  static String get thankYouMessage => 'track_order.thank_you_message'.tr();
  static String get continueShopping => 'track_order.continue_shopping'.tr();
  static String get pending => 'track_order.pending'.tr();
  static String get picked => 'track_order.picked'.tr();
  static String get inProgress => 'track_order.in_progress'.tr();
  static String get outForDelivery => 'track_order.out_for_delivery'.tr();
  static String get arrived => 'track_order.arrived'.tr();
  static String get delivered => 'track_order.delivered'.tr();
  static String get orderStatus => 'track_order.order_status'.tr();
  static String get current => 'track_order.current'.tr();
  static String get confirmDelivery => 'track_order.confirm_delivery'.tr();
  static String get store => 'track_order.store'.tr();
  static String get orderItems => 'track_order.order_items'.tr();
  static String get qty => 'track_order.qty'.tr();
  static String get total => 'track_order.total'.tr();
  static String get payment => 'track_order.payment'.tr();
  static String get driverInfo => 'track_order.driver_info'.tr();
  static String get estimatedArrival => 'track_order.estimated_arrival'.tr();
  static String get estimatedArrivalTime => 'track_order.estimated_arrival_time'.tr();
  static String get deliveryHero => 'track_order.delivery_hero'.tr();
  static String get orderInfo => 'track_order.order_info'.tr();
  static String get orderId => 'track_order.order_id'.tr();
  static String get callFailed => 'track_order.call_failed'.tr();
  static String get whatsappFailed => 'track_order.whatsapp_failed'.tr();
  static String get driverInitial => 'track_order.driver_initial'.tr();
}
