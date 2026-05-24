import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/repository/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartItemQuantityUseCase {
  final CartRepoContract repo;
  UpdateCartItemQuantityUseCase(this.repo);
  Future<BaseResponse<CartResponseEntity>> call({
    required String cartItemId,
    required int quantity,
  }) {
    return repo.updateCartItemQuantity(
      cartItemId: cartItemId,
      quantity: quantity,
    );
  }
}
