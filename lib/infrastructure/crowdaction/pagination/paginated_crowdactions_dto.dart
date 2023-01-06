import 'package:collaction_cms/domain/crowdaction/pagination/paginated_crowdactions.dart';
import 'package:collaction_cms/domain/crowdaction/pagination/pagination.dart';
import 'package:collaction_cms/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:collaction_cms/infrastructure/crowdaction/pagination/pagination_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_crowdactions_dto.g.dart';


@JsonSerializable()
class PaginatedCrowdActionsDto {

  PaginatedCrowdActionsDto({
    required this.crowdactions,
    required this.paginationInfo
  });

  final List<CrowdActionDto> crowdactions;
  final PaginationInfoDto paginationInfo;

  factory PaginatedCrowdActionsDto.fromJson(Map<String, dynamic> json) =>
    _$PaginatedCrowdActionsDtoFromJson(json);

  PaginatedCrowdActions toDomain() {
    return PaginatedCrowdActions(
      crowdActions: 
          crowdactions.map((crowdactionDto) => crowdactionDto.toDomain()).toList(),
      paginationInfo: paginationInfo.toDomain()
    );
  }
}