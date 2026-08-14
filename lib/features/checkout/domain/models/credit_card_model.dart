class CreditCardModel {
  final String? error;
  final String? message;
  final String? url;
  final String? successUrl;
  final String? cancelUrl;
  final String? orderId;

  CreditCardModel({
    this.error,
    this.message,
    this.url,
    this.successUrl,
    this.cancelUrl,
    this.orderId,
  });
}
