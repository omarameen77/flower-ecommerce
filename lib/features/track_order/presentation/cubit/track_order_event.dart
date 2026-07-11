import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';

sealed class TrackOrderEvent {}

class WatchOrder extends TrackOrderEvent {
  final String orderId;
  final TrackOrderEntity? orderData;

  WatchOrder({required this.orderId, this.orderData});
}

class StopWatchingOrder extends TrackOrderEvent {}

class ConfirmDelivery extends TrackOrderEvent {
  final String orderId;

  ConfirmDelivery({required this.orderId});
}
