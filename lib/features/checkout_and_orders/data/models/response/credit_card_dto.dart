import 'package:flower/features/checkout_and_orders/domain/models/credit_card_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_card_dto.g.dart';

@JsonSerializable()
class CreditCardDto {
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "session")
  Session? session;

  CreditCardDto({this.error, this.message, this.session});

  CreditCardModel toModel() => CreditCardModel(
    error: error,
    message: message,
    url: session?.url,
    successUrl: session?.successUrl,
  );

  factory CreditCardDto.fromJson(Map<String, dynamic> json) =>
      _$CreditCardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardDtoToJson(this);
}

@JsonSerializable()
class Session {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "object")
  String? object;
  @JsonKey(name: "amount_subtotal")
  int? amountSubtotal;
  @JsonKey(name: "amount_total")
  int? amountTotal;
  @JsonKey(name: "cancel_url")
  String? cancelUrl;
  @JsonKey(name: "client_reference_id")
  String? clientReferenceId;
  @JsonKey(name: "currency")
  String? currency;
  @JsonKey(name: "customer_email")
  String? customerEmail;
  @JsonKey(name: "livemode")
  bool? livemode;
  @JsonKey(name: "mode")
  String? mode;
  @JsonKey(name: "payment_method_types")
  List<String>? paymentMethodTypes;
  @JsonKey(name: "payment_status")
  String? paymentStatus;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "success_url")
  String? successUrl;
  @JsonKey(name: "ui_mode")
  String? uiMode;
  @JsonKey(name: "url")
  String? url;

  Session({
    this.id,
    this.object,
    this.amountSubtotal,
    this.amountTotal,
    this.cancelUrl,
    this.clientReferenceId,
    this.currency,
    this.customerEmail,
    this.livemode,
    this.mode,
    this.paymentMethodTypes,
    this.paymentStatus,
    this.status,
    this.successUrl,
    this.uiMode,
    this.url,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
