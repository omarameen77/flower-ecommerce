part of 'checkout_cubit.dart';

enum CheckoutStatus { initial, loading, success, paymentPending, error }

class CheckoutState extends Equatable {
  final CheckoutStatus status;
  final String? errorMessage;
  final int selectedPayment;
  final bool isGift;
  final String? paymentUrl;
  final String? successUrl;
  final String? cancelUrl;

  const CheckoutState({
    this.status = CheckoutStatus.initial,
    this.errorMessage,
    this.selectedPayment = 0,
    this.isGift = false,
    this.paymentUrl,
    this.successUrl,
    this.cancelUrl,
  });

  CheckoutState copyWith({
    CheckoutStatus? status,
    String? errorMessage,
    int? selectedPayment,
    bool? isGift,
    String? paymentUrl,
    String? successUrl,
    String? cancelUrl,
    bool clearError = false,
    bool clearPayment = false,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedPayment: selectedPayment ?? this.selectedPayment,
      isGift: isGift ?? this.isGift,
      paymentUrl: clearPayment ? null : (paymentUrl ?? this.paymentUrl),
      successUrl: clearPayment ? null : (successUrl ?? this.successUrl),
      cancelUrl: clearPayment ? null : (cancelUrl ?? this.cancelUrl),
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
    cancelUrl,
  ];
}
