import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_info.freezed.dart';

@freezed
class CrowdActionInfo with _$CrowdActionInfo {
  factory CrowdActionInfo({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    DateTime? joinEndAt,
    required Location country,
    required String description,
    required String category,
    String? subcategory,
    String? password,
  }) = _CrowdActionInfo;
}
