import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_fracture.freezed.dart';

@freezed
class CrowdActionFracture with _$CrowdActionFracture {
  factory CrowdActionFracture({
    required CrowdActionInfo? crowdActionInfo,
    required List<Commitment>? crowdActionCommitments,
    required CrowdActionImages crowdActionImages,
  }) = _CrowdActionFracture;
}
