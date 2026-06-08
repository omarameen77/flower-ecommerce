import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUseCase {
  final AddressRepo _repo;

  AddAddressUseCase(this._repo);

  Future<BaseResponse<List<AddressEntity>>> call({
    required String street,
    required String phone,
    required String city,
    required String lat,
    required String long,
    required String username,
  }) {
    return _repo.addAddress(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
    );
  }
}
