import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';
import 'package:flower/features/product_sections/data/models/response/occasions_response.dart';
import 'package:flower/features/product_sections/data/models/response/products_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'products_sections_api_client.g.dart';

@RestApi()
abstract class ProductsSectionsApiClient {
  @factoryMethod
  factory ProductsSectionsApiClient(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) =>
      _ProductsSectionsApiClient(
        dio,
        baseUrl: baseUrl,
        errorLogger: errorLogger,
      );

  @GET(ProductsSectionsEndPoint.categories)
  Future<CategoriesResponse> getCategories({
    @Query('limit') int? limit,
  });

  @GET(ProductsSectionsEndPoint.occasions)
  Future<OccasionsResponse> getOccasions({
    @Query('limit') int? limit,
  });

  @GET(ProductsSectionsEndPoint.products)
  Future<ProductsResponse> getProducts({
    @Query('limit') int? limit,
    @Query('sort') String? sort,
  });
}
