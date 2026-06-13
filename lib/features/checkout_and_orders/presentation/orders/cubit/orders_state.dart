part of 'orders_cubit.dart';

enum OrdersTab { active, completed }

class OrdersState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final List<OrderModel> allOrders;
  final OrdersTab selectedTab;
  final String? errorMessage;
  final int currentPage;
  final int totalPages;
  final bool hasMore;

  const OrdersState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.allOrders = const [],
    this.selectedTab = OrdersTab.active,
    this.errorMessage,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasMore = false,
  });

  List<OrderModel> get filteredOrders {
    if (selectedTab == OrdersTab.active) {
      return allOrders
          .where((o) => o.state == 'pending' || o.state == 'processing')
          .toList();
    }
    return allOrders
        .where((o) => o.state == 'delivered' || o.state == 'cancelled')
        .toList();
  }

  OrdersState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<OrderModel>? allOrders,
    OrdersTab? selectedTab,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      allOrders: allOrders ?? this.allOrders,
      selectedTab: selectedTab ?? this.selectedTab,
      errorMessage: errorMessage,
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
    selectedTab,
    errorMessage,
    currentPage,
    totalPages,
    hasMore,
  ];
}
