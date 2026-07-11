part of 'track_order_cubit.dart';

class TrackOrderState extends Equatable {
  final BaseState<TrackOrderEntity?> orderData;
  final BaseState<void> confirmDeliveryState;
  final bool confirmSuccess;

  const TrackOrderState({
    this.orderData = const BaseState(),
    this.confirmDeliveryState = const BaseState(),
    this.confirmSuccess = false,
  });

  TrackOrderState copyWith({
    BaseState<TrackOrderEntity?>? orderData,
    BaseState<void>? confirmDeliveryState,
    bool? confirmSuccess,
  }) {
    return TrackOrderState(
      orderData: orderData ?? this.orderData,
      confirmDeliveryState: confirmDeliveryState ?? this.confirmDeliveryState,
      confirmSuccess: confirmSuccess ?? this.confirmSuccess,
    );
  }

  @override
  List<Object?> get props => [orderData, confirmDeliveryState, confirmSuccess];
}
