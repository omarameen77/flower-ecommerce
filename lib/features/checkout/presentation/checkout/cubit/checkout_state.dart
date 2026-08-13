part of 'checkout_cubit.dart';

enum CheckoutStatus { initial, loading, success, paymentPending, error }

class CheckoutState extends Equatable {
  final CheckoutStatus status;
  final String? errorMessage;
  final int selectedPayment;
  final bool isGift;
  final String? paymentUrl;
  final String? successUrl;

  const CheckoutState({
    this.status = CheckoutStatus.initial,
    this.errorMessage,
    this.selectedPayment = 0,
    this.isGift = false,
    this.paymentUrl,
    this.successUrl,
  });

  CheckoutState copyWith({
    CheckoutStatus? status,
    String? errorMessage,
    int? selectedPayment,
    bool? isGift,
    String? paymentUrl,
    String? successUrl,
    bool clearError = false,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedPayment: selectedPayment ?? this.selectedPayment,
      isGift: isGift ?? this.isGift,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      successUrl: successUrl ?? this.successUrl,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    selectedPayment,
    isGift,
    paymentUrl,
    successUrl,
  ];
}
