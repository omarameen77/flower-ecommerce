import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/data/models/request/add_address_request.dart';
import 'package:flower/features/address/data/models/response/addresses_response.dart';

abstract class AddressRemoteDataSourceContract {
  Future<BaseResponse<AddressesResponseDto>> getAddresses();

  Future<BaseResponse<AddressesResponseDto>> addAddress(
    AddAddressRequestDto request,
  );

  Future<BaseResponse<AddressesResponseDto>> updateAddress({
    required String id,
    required AddAddressRequestDto request,
  });

  Future<BaseResponse<AddressesResponseDto>> removeAddress(String id);
}
