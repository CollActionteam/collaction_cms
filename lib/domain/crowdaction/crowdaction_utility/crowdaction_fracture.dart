import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_fracture.freezed.dart';

@freezed
class CrowdActionFractured with _$CrowdActionFractured {
  factory CrowdActionFractured({
    CrowdActionInfo? crowdActionInfo,
    List<Commitment>? crowdActionCommitments,
    CrowdActionImages? crowdActionImages,
  }) = _CrowdActionFractured;
}
