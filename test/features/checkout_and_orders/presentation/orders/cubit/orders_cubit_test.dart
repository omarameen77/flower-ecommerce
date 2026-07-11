import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/domain/models/order_model.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/get_orders_usecase.dart';
import 'package:flower/features/checkout_and_orders/presentation/orders/cubit/orders_cubit.dart';
import 'package:flower/features/checkout_and_orders/presentation/orders/cubit/orders_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_cubit_test.mocks.dart';

@GenerateMocks([GetOrdersUseCase])
void main() {
  late OrdersCubit ordersCubit;
  late MockGetOrdersUseCase mockGetOrdersUseCase;

  setUpAll(() {
    provideDummy<BaseResponse<List<OrderModel>>>(
      SuccessBaseResponse<List<OrderModel>>(data: []),
    );
  });

  setUp(() {
    mockGetOrdersUseCase = MockGetOrdersUseCase();
    ordersCubit = OrdersCubit(mockGetOrdersUseCase);
  });

  tearDown(() {
    ordersCubit.close();
  });

  group('OrdersCubit', () {
    test('initial state is correct', () {
      expect(ordersCubit.state, const OrdersState());
    });

    group('GetOrdersEvent', () {
      test(
        'emits loading then success with orders when use case succeeds',
        () async {
          final tOrders = [
            OrderModel(
              id: "1",
              orderNumber: "ORD-123",
              totalPrice: 100,
              paymentType: "cash",
              state: "pending",
              isPaid: false,
              isDelivered: false,
              createdAt: "2024-01-01",
              productTitle: "Product 1",
              productImage: "image.jpg",
              productPrice: 100,
              quantity: 1,
            ),
          ];

          when(mockGetOrdersUseCase.call(1, 10)).thenAnswer(
            (_) async => SuccessBaseResponse<List<OrderModel>>(data: tOrders),
          );

          ordersCubit.doEvent(const GetOrdersEvent(page: 1, limit: 10));

          expect(ordersCubit.state.isLoading, true);

          await Future.delayed(Duration.zero);

          expect(ordersCubit.state.isLoading, false);
          expect(ordersCubit.state.allOrders, tOrders);
          expect(ordersCubit.state.currentPage, 1);
          verify(mockGetOrdersUseCase.call(1, 10)).called(1);
        },
      );

      test('emits loading then error when use case fails', () async {
        when(mockGetOrdersUseCase.call(1, 10)).thenAnswer(
          (_) async => ErrorBaseResponse<List<OrderModel>>(
            failure: Failure(message: 'Orders error'),
          ),
        );

        ordersCubit.doEvent(const GetOrdersEvent(page: 1, limit: 10));

        expect(ordersCubit.state.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(ordersCubit.state.isLoading, false);
        expect(ordersCubit.state.errorMessage, 'Orders error');
      });
    });

    group('LoadMoreOrdersEvent', () {
      OrderModel _order(int id) => OrderModel(
        id: "$id",
        orderNumber: "ORD-$id",
        totalPrice: id * 100,
        paymentType: "cash",
        state: "pending",
        isPaid: false,
        isDelivered: false,
        createdAt: "2024-01-${id.toString().padLeft(2, '0')}",
        productTitle: "Product $id",
        productImage: "image$id.jpg",
        productPrice: id * 100,
        quantity: id,
      );

      test('loads more orders when hasMore is true', () async {
        // First load initial orders — 10 items so hasMore = true
        final tInitialOrders = List.generate(10, (i) => _order(i + 1));

        when(mockGetOrdersUseCase.call(1, 10)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<List<OrderModel>>(data: tInitialOrders),
        );

        ordersCubit.doEvent(const GetOrdersEvent(page: 1, limit: 10));
        await Future.delayed(Duration.zero);

        // Setup mock for page 2
        final tMoreOrders = [_order(11)];

        when(mockGetOrdersUseCase.call(2, 10)).thenAnswer(
          (_) async => SuccessBaseResponse<List<OrderModel>>(data: tMoreOrders),
        );

        ordersCubit.doEvent(const LoadMoreOrdersEvent());

        expect(ordersCubit.state.isLoadingMore, true);

        await Future.delayed(Duration.zero);

        expect(ordersCubit.state.isLoadingMore, false);
        expect(ordersCubit.state.allOrders.length, 11);
        expect(ordersCubit.state.currentPage, 2);
      });

      test('does not load more when hasMore is false', () async {
        // First load with hasMore = false
        when(mockGetOrdersUseCase.call(1, 10)).thenAnswer(
          (_) async => SuccessBaseResponse<List<OrderModel>>(data: []),
        );

        ordersCubit.doEvent(const GetOrdersEvent(page: 1, limit: 10));
        await Future.delayed(Duration.zero);

        // hasMore should be false since data length < limit
        expect(ordersCubit.state.hasMore, false);

        ordersCubit.doEvent(const LoadMoreOrdersEvent());

        // No state change expected, isLoadingMore should remain false
        expect(ordersCubit.state.isLoadingMore, false);
      });

      test('emits error when load more fails', () async {
        // First load — 10 items so hasMore = true
        final tInitialOrders = List.generate(10, (i) => _order(i + 1));

        when(mockGetOrdersUseCase.call(1, 10)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<List<OrderModel>>(data: tInitialOrders),
        );

        ordersCubit.doEvent(const GetOrdersEvent(page: 1, limit: 10));
        await Future.delayed(Duration.zero);

        // Load more fails
        when(mockGetOrdersUseCase.call(2, 10)).thenAnswer(
          (_) async => ErrorBaseResponse<List<OrderModel>>(
            failure: Failure(message: 'Load more error'),
          ),
        );

        ordersCubit.doEvent(const LoadMoreOrdersEvent());

        expect(ordersCubit.state.isLoadingMore, true);

        await Future.delayed(Duration.zero);

        expect(ordersCubit.state.isLoadingMore, false);
        expect(ordersCubit.state.errorMessage, 'Load more error');
      });
    });
  });
}
