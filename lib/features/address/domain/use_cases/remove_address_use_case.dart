import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveAddressUseCase {
  final AddressRepo _repo;

  RemoveAddressUseCase(this._repo);

  Future<BaseResponse<List<AddressEntity>>> call(String id) {
    return _repo.removeAddress(id);
  }
}
