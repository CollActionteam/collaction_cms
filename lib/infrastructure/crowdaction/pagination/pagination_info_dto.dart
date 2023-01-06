import 'package:collaction_cms/domain/crowdaction/pagination/pagination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_info_dto.g.dart';

@JsonSerializable()
class PaginationInfoDto {

  PaginationInfoDto({
    this.totalItems,
    required this.totalPages,
    required this.page,
    this.pageSize
  });

  final int? totalItems;
  final int totalPages;
  final int page;
  final int? pageSize;
  

  factory PaginationInfoDto.fromJson(Map<String, dynamic> json) =>
    _$PaginationInfoDtoFromJson(json);

  PaginationInfo toDomain() {
    return PaginationInfo(
      totalItems: totalItems,
      totalPages: totalPages,
      page: page,
      pageSize: pageSize
    );
  }
}