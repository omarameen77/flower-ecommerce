import 'package:flower/features/checkout_and_orders/presentation/orders/cubit/orders_cubit.dart';

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

final class SelectTabEvent extends OrdersEvent {
  final OrdersTab tab;

  const SelectTabEvent(this.tab);
}
