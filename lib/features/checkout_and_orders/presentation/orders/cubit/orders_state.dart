part of 'orders_cubit.dart';

class OrdersState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final List<OrderModel> allOrders;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final bool hasMore;

  const OrdersState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.allOrders = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasMore = false,
  });

  List<OrderModel> get filteredOrders {
    return allOrders.where((o) => o.state == 'inProgress').toList();
  }

  OrdersState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<OrderModel>? allOrders,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      allOrders: allOrders ?? this.allOrders,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    allOrders,
    errorMessage,
    currentPage,
    totalPages,
    hasMore,
  ];
}
