
import 'dart:convert';

import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:collaction_cms/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:collaction_cms/domain/core/i_settings_repository.dart';
import 'package:collaction_cms/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:collaction_cms/infrastructure/core/settings_repository.dart';


@LazySingleton(as: ICrowdActionRepository)
class CrowdActionRepository implements ICrowdActionRepository {
  final http.Client _client;
  final ISettingsRepository _settingsRepository;

  const CrowdActionRepository(
    this._client,
    this._settingsRepository  
  );

  @override
  Future<Either<CrowdActionFailure, List<CrowdAction>>> getCrowdActions(
    int page,
    int pageSize,
    Status? status
  ) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions?page=$page&pageSize=$pageSize&status=${status ?? ''}'
        ),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if(response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        return right(
          responseBody['items']
              .map<CrowdAction>((crowdActionJson) => CrowdActionDto.fromJson(crowdActionJson as Map<String, dynamic>)
                  .toDomain())
                  .toList() as List<CrowdAction>
        );
      } else {
        return left(
          const CrowdActionFailure.networkRequestFailed("Network request failed")
        );
      }

    } catch(e) {
      print(e);
      return left(const CrowdActionFailure.serverError("Server Error"));
    }
  }
}