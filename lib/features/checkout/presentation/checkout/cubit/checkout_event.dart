sealed class CheckoutEvent {
  const CheckoutEvent();
}

final class ChangePaymentMethod extends CheckoutEvent {
  final int index;

  const ChangePaymentMethod(this.index);
}

final class ToggleGift extends CheckoutEvent {
  final bool value;

  const ToggleGift(this.value);
}

final class PlaceOrderWithCash extends CheckoutEvent {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String? receiverName;
  final String? receiverPhone;
  final String? receiverAddress;

  const PlaceOrderWithCash({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    this.receiverName,
    this.receiverPhone,
    this.receiverAddress,
  });
}

final class PaymentCompleted extends CheckoutEvent {
  final bool success;

  const PaymentCompleted({this.success = true});
}

final class ResetCheckout extends CheckoutEvent {
  const ResetCheckout();
}

final class PlaceOrderWithCard extends CheckoutEvent {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String? receiverName;
  final String? receiverPhone;
  final String? receiverAddress;

  const PlaceOrderWithCard({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    this.receiverName,
    this.receiverPhone,
    this.receiverAddress,
  });
}
