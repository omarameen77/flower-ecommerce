import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/features/address/data/models/request/add_address_request.dart';
import 'package:flower/features/address/data/models/response/addresses_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'address_api_client.g.dart';

@RestApi()
abstract class AddressApiClient {
  @factoryMethod
  factory AddressApiClient(Dio dio) = _AddressApiClient;

  @GET(AddressEndPoints.addresses)
  Future<AddressesResponseDto> getAddresses();

  @PATCH(AddressEndPoints.addresses)
  Future<AddressesResponseDto> addAddress(@Body() AddAddressRequestDto request);

  @PATCH(AddressEndPoints.addressById)
  Future<AddressesResponseDto> updateAddress(
    @Path('id') String id,
    @Body() AddAddressRequestDto request,
  );

  @DELETE(AddressEndPoints.addressById)
  Future<AddressesResponseDto> removeAddress(@Path('id') String id);
}
