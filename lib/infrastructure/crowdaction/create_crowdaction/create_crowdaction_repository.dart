import 'dart:convert';

import 'package:collaction_cms/domain/auth/i_auth_client_repository.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/crowdaction_creation_failures.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/i_create_crowdation_repository.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:collaction_cms/infrastructure/crowdaction/create_crowdaction/creation_crowdaction_dto.dart';
import 'package:collaction_cms/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:collaction_cms/domain/core/i_settings_repository.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:mime/mime.dart';

@LazySingleton(as: ICreateCrowdActionRepository)
class CreateCrowdActionRepository implements ICreateCrowdActionRepository {
  final http.Client _client;
  final ISettingsRepository _settingsRepository;
  final IAuthClientRepository _authClientRepository;

  CreateCrowdActionRepository(
      this._client, this._settingsRepository, this._authClientRepository);

  @override
  Future<Either<CrowdActionCreationFailure, String>> createCrowdAction(
    CrowdActionInfo crowdActionInfo,
    List<Commitment> commitments,
    CrowdActionImages crowdActionImages,
  ) async {
    try {
      late String crowdActionId;
      var createCrowdActionDto = CreateCrowdActionDto(
          title: crowdActionInfo.title,
          description: crowdActionInfo.description,
          category: crowdActionInfo.category,
          subcategory: crowdActionInfo.subcategory,
          country: crowdActionInfo.country.alpha2!,
          password: crowdActionInfo.password,
          startAt: crowdActionInfo.startDate,
          endAt: crowdActionInfo.endDate,
          joinEndAt: crowdActionInfo.joinEndAt,
          commitments: commitments.map((commitment) {
            return CommitmentDto(
                id: commitment.id,
                tags: commitment.tags,
                label: commitment.label,
                points: commitment.points,
                blocks: commitment.blocks,
                description: commitment.description,
                icon: commitment.iconId);
          }).toList());
      final user = await _authClientRepository.user.first;
      late final Future<String> tokenId;
      user.map((user) async {
        tokenId = user.getIdToken();
      });

      final uri = Uri.parse(
          "${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions");
      final response = await _client.post(uri,
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer ${await tokenId}"
          },
          body: jsonEncode(createCrowdActionDto.toJson()));

      if (response.statusCode == 201) {
        crowdActionId =
            (jsonDecode(response.body) as Map<String, dynamic>)['id'];
        //Add logic that checks for null values in CrowdActionImages
        if (crowdActionImages.banner != null ||
            crowdActionImages.card != null) {
          return await updateCrowdActionImages(
              crowdActionImages, await tokenId, crowdActionId);
        } else {
          return right(crowdActionId);
        }
      } else {
        return left(const CrowdActionCreationFailure.networkRequestFailed(
            "Network request failed"));
      }
    } catch (e) {
      return left(const CrowdActionCreationFailure.serverError("Server error"));
    }
  }

  @override
  Future<Either<CrowdActionCreationFailure, String>> updateCrowdActionImages(
    CrowdActionImages crowdActionImages,
    String tokenId,
    String id,
  ) async {
    try {
      var uri = Uri.parse(
          "${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions/$id/images");
      var request = http.MultipartRequest("POST", uri);
      var headers = <String, String>{
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer $tokenId"
      };

      request.headers.addAll(headers);
      // Handle possible null values
      if (crowdActionImages.card != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'card',
          crowdActionImages.card!,
          filename: 'card',
          contentType: MediaType('image', 'png'),
        ));
      }

      if (crowdActionImages.banner != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'banner',
          crowdActionImages.banner!,
          filename: 'banner',
          contentType: MediaType('image', 'png'),
        ));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        return right(id);
      } else {
        response.stream.listen(
          (value) {},
        );
        return left(const CrowdActionCreationFailure.networkRequestFailed(
            "Network Requested Failed"));
      }
    } catch (e) {
      return left(const CrowdActionCreationFailure.serverError("Server error"));
    }
  }
}
