import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/core/network/model/profile_response/profile_response.dart';
import 'package:flower/features/edit_profile/data/models/edit_profile_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'edit_profile_api_client.g.dart';

@RestApi()
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio, {String baseUrl}) = _EditProfileApiClient;

  @PUT(AuthEndPoint.editProfile)
  Future<ProfileResponseDto> editProfile(@Body() EditProfileRequestDto request);

  @PUT(AuthEndPoint.uploadPhoto)
  @MultiPart()
  Future<ProfileResponseDto> uploadPhoto(@Part(name: "photo") File photo);
}

