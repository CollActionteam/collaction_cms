import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/core/i_settings_repository.dart';
import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/crowdaction_failures.dart';
import '../../domain/crowdaction/i_crowdaction_repository.dart';
import '../../domain/crowdaction/pagination/paginated_crowdactions.dart';
import '../../domain/crowdaction/pagination/pagination.dart';
import 'crowdaction_dto.dart';
import 'pagination/pagination_info_dto.dart';

@LazySingleton(as: ICrowdActionRepository)
class CrowdActionRepository implements ICrowdActionRepository {
  final http.Client _client;
  final ISettingsRepository _settingsRepository;

  const CrowdActionRepository(this._client, this._settingsRepository);

  @override
  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdActions(
    int page,
    int pageSize,
    String? status,
  ) async {
    try {
      final response = await _client.get(
        // TODO: Consider building URI and not using parse, error prone
        Uri.parse(
            '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions?page=$page&pageSize=$pageSize${status != null ? '&status=$status' : ''}'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

        final crowdActions = (responseBody['items'] as List<dynamic>)
            .map<CrowdAction>(
              (crowdActionJson) =>
                  CrowdActionDto.fromJson(crowdActionJson).toDomain(),
            )
            .toList();

        final paginationInfo = (PaginationInfoDto.fromJson(
          responseBody['pageInfo'] as Map<String, dynamic>,
        )).toDomain();

        final paginatedCrowdActions = PaginatedCrowdActions(
          crowdActions: crowdActions,
          paginationInfo: paginationInfo,
        );

        return right(paginatedCrowdActions);
      }

      return left(
        const CrowdActionFailure.networkRequestFailed("Network request failed"),
      );
    } catch (e) {
      return left(const CrowdActionFailure.serverError("Server Error"));
    }
  }

  @override
  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdAction(
    String? slug,
    String? id,
  ) async {
    try {
      final url = slug != null
          ? '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions/slug/$slug'
          : id != null
              ? '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions/$id'
              : throw ('Slug and Id provided');

      final response = await _client.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

        final crowdActions = [CrowdActionDto.fromJson(responseBody).toDomain()];
        const paginationInfo = PaginationInfo(totalPages: 1, page: 1);

        final paginatedCrowdActions = PaginatedCrowdActions(
          crowdActions: crowdActions,
          paginationInfo: paginationInfo,
        );

        return right(paginatedCrowdActions);
      }

      if (response.statusCode == 400) {
        return left(
          const CrowdActionFailure.crowdActionNotFound("CrowdAction not found"),
        );
      }

      return left(
        const CrowdActionFailure.networkRequestFailed(
          "Network requested Failed",
        ),
      );
    } catch (e) {
      return left(CrowdActionFailure.serverError(e));
    }
  }
}
