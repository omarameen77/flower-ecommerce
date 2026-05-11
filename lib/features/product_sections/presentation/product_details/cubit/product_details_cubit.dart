import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:flower/features/product_sections/presentation/product_details/cubit/product_details_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductByIdUseCase getProductByIdUseCase;

  ProductDetailsCubit({required this.getProductByIdUseCase})
    : super(const ProductDetailsState());

  void doEvent(ProductDetailsEvent event) {
    switch (event) {
      case GetProductDetailsEvent():
        _getProduct(event.id);
        break;
    }
  }

  Future<void> _getProduct(String id) async {
    emit(
      state.copyWith(
        productBaseState: const BaseState<ProductEntity>(isLoading: true),
      ),
    );
    final result = await getProductByIdUseCase.call(id);
    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            productBaseState: BaseState<ProductEntity>(data: result.data),
          ),
        );
        break;
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            productBaseState: BaseState<ProductEntity>(
              errorMessage: result.failure.message,
            ),
          ),
        );
        break;
    }
  }
}
