import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/domain/entity/add_to_cart_request_entity.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/repository/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUseCase {
  final CartRepoContract repo;
  AddProductToCartUseCase(this.repo);
  Future<BaseResponse<CartResponseEntity>> call(
    AddToCartRequestEntity request,
  ) {
    return repo.addProductToCart(request);
  }
}
