import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:flower/features/address/domain/use_cases/address_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUseCase {
  final AddressRepo _repo;

  AddAddressUseCase(this._repo);

  Future<BaseResponse<List<AddressEntity>>> call(AddressParams params) {
    return _repo.addAddress(params);
  }
}
