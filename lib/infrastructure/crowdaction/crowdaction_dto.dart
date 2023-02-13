import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_dto.g.dart';

@JsonSerializable()
class CrowdActionDto {
  CrowdActionDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.commitments,
    required this.images,
    required this.participantCount,
    required this.status,
    required this.joinStatus,
    required this.createdAt,
    required this.endAt,
    this.password,
    this.subcategory,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final LocationDto location;
  final List<CommitmentDto> commitments;
  final ImagesDto images;
  final int participantCount;
  final Status status;
  final JoinStatus joinStatus;
  final String createdAt;
  final String endAt;
  final String? password;
  final String? subcategory;

  CrowdAction toDomain() {
    return CrowdAction(
      id: id,
      title: title,
      description: description,
      category: category,
      location: location.toDomain(),
      commitments: commitments.map((option) => option.toDomain()).toList(),
      images: images.toDomain(),
      participantCount: participantCount,
      status: status,
      joinStatus: joinStatus,
      createdAt: DateTime.parse(createdAt),
      endAt: DateTime.parse(endAt),
      password: password,
      subcategory: subcategory,
    );
  }

  factory CrowdActionDto.fromJson(Map<String, dynamic> json) =>
      _$CrowdActionDtoFromJson(json);
}

@JsonSerializable()
class ImagesDto {
  ImagesDto({required this.card, required this.banner});

  final String card;
  final String banner;

  Images toDomain() {
    return Images(card: card, banner: banner);
  }

  factory ImagesDto.fromJson(Map<String, dynamic> json) =>
      _$ImagesDtoFromJson(json);
}

@JsonSerializable()
class LocationDto {
  LocationDto({
    required this.code,
    required this.name,
  });

  final String code;
  final String name;

  Location toDomain() {
    return Location(
      code: code,
      name: name,
    );
  }

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}

@JsonSerializable()
class CommitmentDto {
  CommitmentDto({
    required this.id,
    required this.type,
    required this.label,
    required this.points,
    required this.blocks,
    this.description,
    this.icon,
  });

  final String id;
  final String type;
  final String label;
  final int points;
  final List<String> blocks;
  final String? description;
  final String? icon;

  Commitment toDomain() {
    return Commitment(
      id: id,
      type: type,
      label: label,
      points: points,
      blocks: blocks,
      description: description,
      iconId: icon,
    );
  }

  factory CommitmentDto.fromJson(Map<String, dynamic> json) =>
      _$CommitmentDtoFromJson(json);
}
