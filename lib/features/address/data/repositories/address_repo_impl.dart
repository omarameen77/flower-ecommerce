import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/data/datasources/address_remote_data_source.dart';
import 'package:flower/features/address/data/models/request/add_address_request.dart';
import 'package:flower/features/address/data/models/response/addresses_response.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRepo)
class AddressRepoImpl implements AddressRepo {
  final AddressRemoteDataSourceContract addressRemoteDataSourceContract;

  AddressRepoImpl({required this.addressRemoteDataSourceContract});

  BaseResponse<List<AddressEntity>> _map(BaseResponse<AddressesResponseDto> r) {
    switch (r) {
      case SuccessBaseResponse<AddressesResponseDto>():
        return SuccessBaseResponse<List<AddressEntity>>(
          data: r.data.all.map((dto) => dto.toEntity()).toList(),
        );
      case ErrorBaseResponse<AddressesResponseDto>():
        return ErrorBaseResponse<List<AddressEntity>>(failure: r.failure);
    }
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> getAddresses() async {
    final response = await addressRemoteDataSourceContract.getAddresses();
    return _map(response);
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> addAddress({
    required String street,
    required String phone,
    required String city,
    required String lat,
    required String long,
    required String username,
  }) async {
    final response = await addressRemoteDataSourceContract.addAddress(
      AddAddressRequestDto(
        street: street,
        phone: phone,
        city: city,
        lat: lat,
        long: long,
        username: username,
      ),
    );
    return _map(response);
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> updateAddress({
    required String id,
    required String street,
    required String phone,
    required String city,
    required String lat,
    required String long,
    required String username,
  }) async {
    final response = await addressRemoteDataSourceContract.updateAddress(
      id: id,
      request: AddAddressRequestDto(
        street: street,
        phone: phone,
        city: city,
        lat: lat,
        long: long,
        username: username,
      ),
    );
    return _map(response);
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> removeAddress(String id) async {
    final response = await addressRemoteDataSourceContract.removeAddress(id);
    return _map(response);
  }
}
