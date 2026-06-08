import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/address/api/api_client/address_api_client.dart';
import 'package:flower/features/address/data/datasources/address_remote_data_source.dart';
import 'package:flower/features/address/data/models/request/add_address_request.dart';
import 'package:flower/features/address/data/models/response/addresses_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AddressRemoteDataSourceContract)
class AddressRemoteDataSourceImpl implements AddressRemoteDataSourceContract {
  final AddressApiClient addressApiClient;

  AddressRemoteDataSourceImpl({required this.addressApiClient});

  @override
  Future<BaseResponse<AddressesResponseDto>> getAddresses() async {
    try {
      final response = await addressApiClient.getAddresses();
      return SuccessBaseResponse<AddressesResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<AddressesResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<AddressesResponseDto>> addAddress(
    AddAddressRequestDto request,
  ) async {
    try {
      final response = await addressApiClient.addAddress(request);
      return SuccessBaseResponse<AddressesResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<AddressesResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<AddressesResponseDto>> updateAddress({
    required String id,
    required AddAddressRequestDto request,
  }) async {
    try {
      final response = await addressApiClient.updateAddress(id, request);
      return SuccessBaseResponse<AddressesResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<AddressesResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<AddressesResponseDto>> removeAddress(String id) async {
    try {
      final response = await addressApiClient.removeAddress(id);
      return SuccessBaseResponse<AddressesResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<AddressesResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }
}
