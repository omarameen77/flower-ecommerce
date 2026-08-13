import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/orders/domain/models/order_model.dart';
import 'package:flower/features/orders/domain/models/order_state.dart';
import 'package:flower/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:flower/features/orders/presentation/orders/cubit/orders_event.dart';
import 'package:injectable/injectable.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;

  OrdersCubit(this._getOrdersUseCase) : super(const OrdersState());

  Future<void> doEvent(OrdersEvent event) async {
    switch (event) {
      case GetOrdersEvent():
        await _getOrders(event.page, event.limit);
      case LoadMoreOrdersEvent():
        await _loadMoreOrders();
    }
  }

  Future<void> _getOrders(int page, int limit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await _getOrdersUseCase.call(page, limit);

    switch (response) {
      case SuccessBaseResponse<List<OrderModel>>():
        emit(
          state.copyWith(
            isLoading: false,
            allOrders: response.data,
            currentPage: page,
            hasMore: response.data.length >= limit,
          ),
        );
      case ErrorBaseResponse<List<OrderModel>>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: response.failure.message,
          ),
        );
    }
  }

  Future<void> _loadMoreOrders() async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;
    const limit = 10;

    final response = await _getOrdersUseCase.call(nextPage, limit);

    switch (response) {
      case SuccessBaseResponse<List<OrderModel>>():
        emit(
          state.copyWith(
            isLoadingMore: false,
            allOrders: [...state.allOrders, ...response.data],
            currentPage: nextPage,
            hasMore: response.data.length >= limit,
          ),
        );
      case ErrorBaseResponse<List<OrderModel>>():
        emit(
          state.copyWith(
            isLoadingMore: false,
            errorMessage: response.failure.message,
          ),
        );
    }
  }
}
