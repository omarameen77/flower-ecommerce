import 'package:dio/dio.dart';
import 'package:flower/core/network/dio_helper.dart';
import 'package:flower/features/auth/api/api_client/auth_api_client.dart';
import 'package:flower/features/product_sections/api/api_client/products_sections_api_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio get dio => DioHelper.dio;

  @singleton
  AuthApiClient authApi(Dio dio) => AuthApiClient(dio);

   @singleton
  ProductsSectionsApiClient productsApi(Dio dio) =>
      ProductsSectionsApiClient(dio);
}
