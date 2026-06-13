import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/address/data/datasources/address_remote_data_source.dart';
import 'package:flower/features/address/data/models/request/add_address_request.dart';
import 'package:flower/features/address/data/models/response/addresses_response.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/repositories/address_repo.dart';
import 'package:flower/features/address/domain/use_cases/address_params.dart';
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

  AddAddressRequestDto _toDto(AddressParams p) => AddAddressRequestDto(
    street: p.street,
    phone: p.phone,
    city: p.city,
    lat: p.lat,
    long: p.long,
    username: p.username,
  );

  @override
  Future<BaseResponse<List<AddressEntity>>> getAddresses() async {
    final response = await addressRemoteDataSourceContract.getAddresses();
    return _map(response);
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> addAddress(
    AddressParams params,
  ) async {
    final response = await addressRemoteDataSourceContract.addAddress(
      _toDto(params),
    );
    return _map(response);
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> updateAddress({
    required String id,
    required AddressParams params,
  }) async {
    final response = await addressRemoteDataSourceContract.updateAddress(
      id: id,
      request: _toDto(params),
    );
    return _map(response);
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> removeAddress(String id) async {
    final response = await addressRemoteDataSourceContract.removeAddress(id);
    return _map(response);
  }
}
