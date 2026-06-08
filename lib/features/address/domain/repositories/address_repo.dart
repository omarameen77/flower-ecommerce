import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';

abstract class AddressRepo {
  Future<BaseResponse<List<AddressEntity>>> getAddresses();

  Future<BaseResponse<List<AddressEntity>>> addAddress({
    required String street,
    required String phone,
    required String city,
    required String lat,
    required String long,
    required String username,
  });

  Future<BaseResponse<List<AddressEntity>>> updateAddress({
    required String id,
    required String street,
    required String phone,
    required String city,
    required String lat,
    required String long,
    required String username,
  });

  Future<BaseResponse<List<AddressEntity>>> removeAddress(String id);
}
