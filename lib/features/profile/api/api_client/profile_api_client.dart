import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/core/network/model/profile_response/profile_response.dart';
import 'package:flower/features/profile/data/models/edit_profile_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @GET(AuthEndPoint.profile)
  Future<ProfileResponseDto> getProfile();

  @PUT(AuthEndPoint.editProfile)
  Future<ProfileResponseDto> editProfile(@Body() EditProfileRequestDto request);

  @PUT(AuthEndPoint.uploadPhoto)
  @MultiPart()
  Future<ProfileResponseDto> uploadPhoto(@Part(name: "photo") File photo);
}
