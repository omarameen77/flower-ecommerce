part of 'checkout_cubit.dart';

enum CheckoutStatus { initial, loading, success, paymentPending, error }

class CheckoutState extends Equatable {
  final CheckoutStatus status;
  final String? errorMessage;
  final int selectedPayment;
  final bool isGift;
  final String? paymentUrl;
  final String? successUrl;
  // TODO: static default address — replace with fetched user address after address feature
  final String street;
  final String phone;
  final String city;

  const CheckoutState({
    this.status = CheckoutStatus.initial,
    this.errorMessage,
    this.selectedPayment = 0,
    this.isGift = false,
    this.paymentUrl,
    this.successUrl,
    this.street = '2XVP+XC - Sheikh Zayed.....',
    this.phone = '+201202222222',
    this.city = 'Sheikh Zayed',
  });

  CheckoutState copyWith({
    CheckoutStatus? status,
    String? errorMessage,
    int? selectedPayment,
    bool? isGift,
    String? paymentUrl,
    String? successUrl,
    String? street,
    String? phone,
    String? city,
    bool clearError = false,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedPayment: selectedPayment ?? this.selectedPayment,
      isGift: isGift ?? this.isGift,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      successUrl: successUrl ?? this.successUrl,
      street: street ?? this.street,
      phone: phone ?? this.phone,
      city: city ?? this.city,
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, selectedPayment, isGift, paymentUrl, successUrl, street, phone, city];
}
