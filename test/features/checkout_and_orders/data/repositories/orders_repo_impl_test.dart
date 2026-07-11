import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/data/datasources/orders_remote_data_source.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/orders_response_dto.dart';
import 'package:flower/features/checkout_and_orders/data/repositories/orders_repo_impl.dart';
import 'package:flower/features/checkout_and_orders/domain/models/order_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDataSourceContract])
void main() {
  late OrdersRepoImpl ordersRepoImpl;
  late MockOrdersRemoteDataSourceContract mockOrdersRemoteDataSourceContract;

  setUpAll(() {
    provideDummy<BaseResponse<OrdersResponseDto>>(
      SuccessBaseResponse<OrdersResponseDto>(data: OrdersResponseDto()),
    );
  });

  setUp(() {
    mockOrdersRemoteDataSourceContract = MockOrdersRemoteDataSourceContract();
    ordersRepoImpl = OrdersRepoImpl(
      remoteDataSource: mockOrdersRemoteDataSourceContract,
    );
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
    test(
      'should return SuccessBaseResponse<List<OrderModel>> when remote data source is successful',
      () async {
        when(
          mockOrdersRemoteDataSourceContract.getOrders(tPage, tLimit),
        ).thenAnswer(
          (_) async =>
              SuccessBaseResponse<OrdersResponseDto>(data: tOrdersResponseDto),
        );

        final result = await ordersRepoImpl.getOrders(tPage, tLimit);

        expect(result, isA<SuccessBaseResponse<List<OrderModel>>>());
        final successResult = result as SuccessBaseResponse<List<OrderModel>>;
        expect(successResult.data.length, 1);
        expect(successResult.data.first.orderNumber, "ORD-123");
        verify(
          mockOrdersRemoteDataSourceContract.getOrders(tPage, tLimit),
        ).called(1);
        verifyNoMoreInteractions(mockOrdersRemoteDataSourceContract);
      },
    );

    test(
      'should return ErrorBaseResponse<List<OrderModel>> when remote data source fails',
      () async {
        final tFailure = Failure(message: 'Remote Error');
        when(
          mockOrdersRemoteDataSourceContract.getOrders(tPage, tLimit),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<OrdersResponseDto>(failure: tFailure),
        );

        final result = await ordersRepoImpl.getOrders(tPage, tLimit);

        expect(result, isA<ErrorBaseResponse<List<OrderModel>>>());
        final errorResult = result as ErrorBaseResponse<List<OrderModel>>;
        expect(errorResult.failure, tFailure);
        verify(
          mockOrdersRemoteDataSourceContract.getOrders(tPage, tLimit),
        ).called(1);
        verifyNoMoreInteractions(mockOrdersRemoteDataSourceContract);
      },
    );
  });
}
