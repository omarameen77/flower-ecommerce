import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/api/api_client/orders_api_client.dart';
import 'package:flower/features/checkout_and_orders/api/datasources/orders_remote_data_source_impl.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/orders_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OrdersApiClient])
void main() {
  late OrdersRemoteDataSourceImpl ordersRemoteDataSourceImpl;
  late MockOrdersApiClient mockOrdersApiClient;

  setUp(() {
    mockOrdersApiClient = MockOrdersApiClient();
    ordersRemoteDataSourceImpl =
        OrdersRemoteDataSourceImpl(ordersApiClient: mockOrdersApiClient);
  });

  final tPage = 1;
  final tLimit = 10;

  final tOrdersResponseDto = OrdersResponseDto(
    message: "success",
    orders: [
      OrderDto(
        id: "1",
        orderNumber: "ORD-123",
        totalPrice: 100,
        paymentType: "cash",
        state: "delivered",
        isPaid: true,
        isDelivered: true,
        createdAt: "2024-01-01",
        updatedAt: "2024-01-02",
        user: "user1",
      ),
    ],
    metadata: OrdersMetadataDto(
      currentPage: 1,
      totalPages: 1,
      limit: 10,
      totalItems: 1,
    ),
  );

  group('getOrders', () {
    test('should return SuccessBaseResponse when api client returns orders',
        () async {
      when(mockOrdersApiClient.getOrders(tPage, tLimit))
          .thenAnswer((_) async => tOrdersResponseDto);

      final result = await ordersRemoteDataSourceImpl.getOrders(tPage, tLimit);

      expect(result, isA<SuccessBaseResponse<OrdersResponseDto>>());
      final successResult = result as SuccessBaseResponse<OrdersResponseDto>;
      expect(successResult.data, tOrdersResponseDto);
      verify(mockOrdersApiClient.getOrders(tPage, tLimit)).called(1);
      verifyNoMoreInteractions(mockOrdersApiClient);
    });

    test('should return ErrorBaseResponse when api client throws an exception',
        () async {
      when(mockOrdersApiClient.getOrders(tPage, tLimit))
          .thenThrow(Exception('Network error'));

      final result = await ordersRemoteDataSourceImpl.getOrders(tPage, tLimit);

      expect(result, isA<ErrorBaseResponse<OrdersResponseDto>>());
      verify(mockOrdersApiClient.getOrders(tPage, tLimit)).called(1);
      verifyNoMoreInteractions(mockOrdersApiClient);
    });
  });
}
