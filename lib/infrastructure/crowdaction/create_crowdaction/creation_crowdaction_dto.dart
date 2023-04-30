import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collaction_cms/infrastructure/crowdaction/crowdaction_dto.dart';

part 'creation_crowdaction_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateCrowdActionDto {
  CreateCrowdActionDto({
    required this.title,
    required this.description,
    required this.category,
    this.subcategory,
    required this.country,
    this.password,
    required this.startAt,
    required this.endAt,
    this.joinEndAt,
    required this.commitments,
  });

  final String title;
  final String description;
  final String category;
  final String? subcategory;
  final String country;
  final String? password;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime? joinEndAt;
  final List<CommitmentDto> commitments;

  factory CreateCrowdActionDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCrowdActionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCrowdActionDtoToJson(this);
}
