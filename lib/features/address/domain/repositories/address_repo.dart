import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/use_cases/address_params.dart';

abstract interface class AddressRepo {
  Future<BaseResponse<List<AddressEntity>>> getAddresses();

  Future<BaseResponse<List<AddressEntity>>> addAddress(AddressParams params);

  Future<BaseResponse<List<AddressEntity>>> updateAddress({
    required String id,
    required AddressParams params,
  });

  Future<BaseResponse<List<AddressEntity>>> removeAddress(String id);
}
