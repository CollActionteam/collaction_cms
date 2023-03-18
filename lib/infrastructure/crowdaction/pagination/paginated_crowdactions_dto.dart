import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/crowdaction/pagination/paginated_crowdactions.dart';
import '../crowdaction_dto.dart';
import 'pagination_info_dto.dart';

part 'paginated_crowdactions_dto.g.dart';

@JsonSerializable()
class PaginatedCrowdActionsDto {
  PaginatedCrowdActionsDto(
      {required this.crowdactions, required this.paginationInfo});

  final List<CrowdActionDto> crowdactions;
  final PaginationInfoDto paginationInfo;

  factory PaginatedCrowdActionsDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedCrowdActionsDtoFromJson(json);

  PaginatedCrowdActions toDomain() {
    return PaginatedCrowdActions(
        crowdActions: crowdactions
            .map((crowdactionDto) => crowdactionDto.toDomain())
            .toList(),
        paginationInfo: paginationInfo.toDomain());
  }
}
