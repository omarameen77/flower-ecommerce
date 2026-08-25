import 'package:easy_localization/easy_localization.dart';

abstract class CheckoutConstants {
  CheckoutConstants._();

  static String get title => 'checkout.title'.tr();
  static String get shippingAddress => 'checkout.shipping_address'.tr();
  static String get addNewAddress => 'checkout.add_new_address'.tr();
  static String get paymentMethod => 'checkout.payment_method'.tr();
  static String get cashOnDelivery => 'checkout.cash_on_delivery'.tr();
  static String get creditCard => 'checkout.credit_card'.tr();
  static String get sendAsGift => 'checkout.send_as_gift'.tr();
  static String get receiverName => 'checkout.receiver_name'.tr();
  static String get receiverPhone => 'checkout.receiver_phone'.tr();
  static String get receiverAddress => 'checkout.receiver_address'.tr();
  static String get placeOrder => 'checkout.place_order'.tr();
  static String get orderPlaced => 'checkout.order_placed'.tr();
  static String get thankYou => 'checkout.thank_you'.tr();
  static String get thankYouMessage => 'checkout.thank_you_message'.tr();
  static String get continueShopping => 'checkout.continue_shopping'.tr();
  static String get subtotal => 'checkout.subtotal'.tr();
  static String get delivery => 'checkout.delivery'.tr();
  static String get total => 'checkout.total'.tr();
  static String get egp => '\$ ';
  static String get deliveryTime => 'checkout.delivery_time'.tr();
  static String get instant => 'checkout.instant'.tr();
  static String get paymentCompleted => 'checkout.payment_completed'.tr();
  static String get selectAddressRequired =>
      'checkout.select_address_required'.tr();
}
