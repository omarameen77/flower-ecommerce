sealed class OrdersEvent {
  const OrdersEvent();
}

final class GetOrdersEvent extends OrdersEvent {
  final int page;
  final int limit;

  const GetOrdersEvent({this.page = 1, this.limit = 10});
}

final class LoadMoreOrdersEvent extends OrdersEvent {
  const LoadMoreOrdersEvent();
}
