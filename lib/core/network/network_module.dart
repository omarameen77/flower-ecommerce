import 'package:dio/dio.dart';
import 'package:flower/core/network/dio_helper.dart';
import 'package:flower/core/profile/api/api_client/profile_api_client.dart';
import 'package:flower/features/auth/api/api_client/auth_api_client.dart';
import 'package:flower/features/edit_profile/api/api_client/edit_profile_api_client.dart';
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

  @singleton
  ProfileApiClient profileApi(Dio dio) => ProfileApiClient(dio);

  @singleton
  EditProfileApiClient editProfileApi(Dio dio) => EditProfileApiClient(dio);
}
