import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collaction_cms/presentation/core/icons/icons_map.dart';

//Check if freezed is necessary here.
part 'crowdaction.freezed.dart';

@freezed
class CrowdAction with _$CrowdAction {
  
  const factory CrowdAction({
    required String id,
    required String type,
    required String title,
    required String description,
    required String category,
    required Location location,
    required List<CommitmentOption> commitmentOptions,
    required Images images,
    required int participantCount,
    required Status status,
    required JoinStatus joinStatus,
    required DateTime createdAt,
    required DateTime endAt,
    String? password,
    String? subcategory,
  }) = _CrowdAction;
}

class Images{
    const Images({
      required String card,
      required String banner
    });
}

class Location{
  const Location({
    required this.code,
    required this.name
  });

  final String code;
  final String name;
}

enum Status{
  @JsonValue('STARTED')
  started,
  @JsonValue('WAITING')
  waiting,
  @JsonValue('ENDED')
  ended;

  static Status? enumOf(String? input) {
    switch(input) {
      case "Started": return Status.started;
      case "Waiting": return Status.waiting;
      case "Ended": return Status.ended;
      default :
        return null;
    }
  }
}

extension Values on Status {
  String? get value {
    switch(this) {
      case Status.started: return "STARTED";
      case Status.waiting: return "WAITING";
      case Status.ended: return "ENDED";
      default: return null;
    }
  }

  
}

enum JoinStatus {
  @JsonValue('OPEN')
  open,
  @JsonValue('CLOSED')
  closed,
}

class CommitmentOption{

  CommitmentOption({
    required String id,
    required String type,
    required String label,
    required int points,
    required List<String> blocks,
    String? description, 
    required String? iconId
  });

  final String? iconId = null;

  IconData get icon => mapIcon(iconId);
}





