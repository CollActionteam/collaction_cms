import 'dart:convert';

import 'package:collaction_cms/domain/auth/i_auth_client_repository.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/crowdaction_creation_failures.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/i_create_crowdation_repository.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:collaction_cms/infrastructure/crowdaction/create_crowdaction/creation_crowdaction_dto.dart';
import 'package:collaction_cms/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:collaction_cms/domain/core/i_settings_repository.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

@LazySingleton(as: ICreateCrowdActionRepository)
class CreateCrowdActionRepository implements ICreateCrowdActionRepository {
  final http.Client _client;
  final ISettingsRepository _settingsRepository;
  final IAuthClientRepository _authClientRepository;

  CreateCrowdActionRepository(
      this._client, this._settingsRepository, this._authClientRepository);

  @override
  Future<Either<CrowdActionCreationFailure, Unit>> createCrowdAction(
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
          country: crowdActionInfo.country.code,
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
                blocks: commitment.blocks);
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
          body: jsonEncode(createCrowdActionDto));

      if (response.statusCode == 201) {
        crowdActionId =
            (jsonDecode(response.body) as Map<String, dynamic>)['id'];
        return await updateCrowdActionImages(
            crowdActionImages, await tokenId, crowdActionId);
      } else {
        return left(const CrowdActionCreationFailure.networkRequestFailed(
            "Network request failed"));
      }
    } catch (e) {
      return left(const CrowdActionCreationFailure.serverError("Server error"));
    }
  }

  @override
  Future<Either<CrowdActionCreationFailure, Unit>> updateCrowdActionImages(
    CrowdActionImages crowdActionImages,
    String tokenId,
    String id,
  ) async {
    try {
      var uri = Uri.parse(
          "${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions/$id/images");
      var request = http.MultipartRequest("POST", uri);
      var headers = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $tokenId"
      };
      request.headers.addAll(headers);
      request.files
          .add(http.MultipartFile.fromBytes('card', crowdActionImages.card));
      request.files.add(
          http.MultipartFile.fromBytes('banner', crowdActionImages.banner));
      var response = await request.send();
      if (response.statusCode == 201) {
        return right(unit);
      } else {
        return left(const CrowdActionCreationFailure.networkRequestFailed(
            "Network Requested Failed"));
      }
    } catch (e) {
      return left(const CrowdActionCreationFailure.serverError("Server error"));
    }
  }
}
