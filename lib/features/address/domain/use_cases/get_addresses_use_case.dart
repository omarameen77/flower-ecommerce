import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddressesUseCase {
  final AddressRepo _repo;

  GetAddressesUseCase(this._repo);

  Future<BaseResponse<List<AddressEntity>>> call() {
    return _repo.getAddresses();
  }
}
