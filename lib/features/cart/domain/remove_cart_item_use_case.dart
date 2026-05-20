import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/repository/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveCartItemUseCase {
  final CartRepoContract repo;
  RemoveCartItemUseCase(this.repo);
  Future<BaseResponse<CartResponseEntity>> call({required String cartItemId}) {
    return repo.removeCartItem(cartItemId: cartItemId);
  }
}
