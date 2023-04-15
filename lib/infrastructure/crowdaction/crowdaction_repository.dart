import 'dart:convert';

import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_cms/domain/crowdaction/pagination/paginated_crowdactions.dart';
import 'package:collaction_cms/domain/crowdaction/pagination/pagination.dart';
import 'package:collaction_cms/infrastructure/crowdaction/pagination/pagination_info_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:collaction_cms/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:collaction_cms/domain/core/i_settings_repository.dart';
import 'package:collaction_cms/infrastructure/crowdaction/crowdaction_dto.dart';

@LazySingleton(as: ICrowdActionRepository)
class CrowdActionRepository implements ICrowdActionRepository {
  final http.Client _client;
  final ISettingsRepository _settingsRepository;

  const CrowdActionRepository(this._client, this._settingsRepository);

  @override
  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdActions(
      int page, int pageSize, String? status) async {
    try {
      final response = await _client.get(
        Uri.parse(
            '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions?page=$page&pageSize=$pageSize${status != null ? '&status=$status' : ''}'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

        var crowdActions = (responseBody['items'] as List<dynamic>)
            .map<CrowdAction>((crowdActionJson) =>
                CrowdActionDto.fromJson(crowdActionJson).toDomain())
            .toList();

        var paginationInfo = (PaginationInfoDto.fromJson(
                responseBody['pageInfo'] as Map<String, dynamic>))
            .toDomain();

        var paginatedCrowdActions = PaginatedCrowdActions(
            crowdActions: crowdActions, paginationInfo: paginationInfo);

        return right(paginatedCrowdActions);
      } else {
        return left(const CrowdActionFailure.networkRequestFailed(
            "Network request failed"));
      }
    } catch (e) {
      print(e);
      return left(const CrowdActionFailure.serverError("Server Error"));
    }
  }

  @override
  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdAction(
      String? slug, String? id) async {
    try {
      String url;
      if (slug != null) {
        url =
            '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions/slug/$slug';
      } else if (id != null) {
        url =
            '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions/$id';
      } else {
        throw ('Slug and Id provided');
      }

      final response = await _client.get(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

        var crowdActions = [CrowdActionDto.fromJson(responseBody).toDomain()];

        var paginationInfo = const PaginationInfo(totalPages: 1, page: 1);

        var paginatedCrowdActions = PaginatedCrowdActions(
            crowdActions: crowdActions, paginationInfo: paginationInfo);

        return right(paginatedCrowdActions);
      }

      if (response.statusCode == 400) {
        return left(const CrowdActionFailure.crowdActionNotFound(
            "CrowdAction not found"));
      } else {
        print(response.statusCode);
        print(response.body);
        return left(const CrowdActionFailure.networkRequestFailed(
            "Network requested Failed"));
      }
    } catch (e) {
      print(e);
      return left(CrowdActionFailure.serverError(e));
    }
  }
}
