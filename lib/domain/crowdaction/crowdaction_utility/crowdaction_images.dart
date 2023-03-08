import 'dart:typed_data';

import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_images.freezed.dart';

@freezed
class CrowdActionImages with _$CrowdActionImages {
  factory CrowdActionImages({
    required Uint8List card,
    required Uint8List banner,
  }) = _CrowdActionImages;
}
