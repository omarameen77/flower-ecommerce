import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/domain/models/order_model.dart';
import 'package:flower/features/checkout_and_orders/domain/repositories/orders_repo.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/get_orders_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_orders_usecase_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  late GetOrdersUseCase getOrdersUseCase;
  late MockOrdersRepo mockOrdersRepo;

  setUpAll(() {
    provideDummy<BaseResponse<List<OrderModel>>>(
      SuccessBaseResponse<List<OrderModel>>(data: []),
    );
  });

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
    getOrdersUseCase = GetOrdersUseCase(mockOrdersRepo);
  });

  final tPage = 1;
  final tLimit = 10;

  final tOrdersList = [
    OrderModel(
      id: "1",
      orderNumber: "ORD-123",
      totalPrice: 100,
      paymentType: "cash",
      state: "delivered",
      isPaid: true,
      isDelivered: true,
      createdAt: "2024-01-01",
      productTitle: "Product 1",
      productImage: "image.jpg",
      productPrice: 100,
      quantity: 1,
    ),
  ];

  test(
      'should return SuccessBaseResponse when repository call is successful',
      () async {
    when(mockOrdersRepo.getOrders(tPage, tLimit))
        .thenAnswer((_) async =>
            SuccessBaseResponse<List<OrderModel>>(data: tOrdersList));

    final result = await getOrdersUseCase.call(tPage, tLimit);

    expect(result, isA<SuccessBaseResponse<List<OrderModel>>>());
    final successResult = result as SuccessBaseResponse<List<OrderModel>>;
    expect(successResult.data, tOrdersList);
    verify(mockOrdersRepo.getOrders(tPage, tLimit)).called(1);
    verifyNoMoreInteractions(mockOrdersRepo);
  });

  test('should return ErrorBaseResponse when repository call fails', () async {
    final tFailure = Failure(message: 'Orders fetch failed');
    when(mockOrdersRepo.getOrders(tPage, tLimit))
        .thenAnswer((_) async =>
            ErrorBaseResponse<List<OrderModel>>(failure: tFailure));

    final result = await getOrdersUseCase.call(tPage, tLimit);

    expect(result, isA<ErrorBaseResponse<List<OrderModel>>>());
    final errorResult = result as ErrorBaseResponse<List<OrderModel>>;
    expect(errorResult.failure, tFailure);
    verify(mockOrdersRepo.getOrders(tPage, tLimit)).called(1);
    verifyNoMoreInteractions(mockOrdersRepo);
  });
}
