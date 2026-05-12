import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<BaseState<List<ProductEntity>>> {
  final GetProductsUseCase getProductUseCase;

  SearchCubit(this.getProductUseCase) : super(const BaseState(data: []));

  Future<void> search(String keyword) async {
    emit(const BaseState(isLoading: true, data: []));

    final result = await getProductUseCase.call(keyword: keyword, limit: 20);

    switch (result) {
      case SuccessBaseResponse():
        emit(BaseState(data: result.data));

      case ErrorBaseResponse():
        emit(BaseState(errorMessage: result.failure.message));
    }
  }

  void clear() {
    emit(const BaseState(data: []));
  }
}
