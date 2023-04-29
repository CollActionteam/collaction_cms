import 'dart:typed_data';

import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';

class CrowdActionImagesFormController {
  CrowdActionImagesFormController();

  final Map<String, ValidationOutput> _validationOutputs = {
    'card': ValidationOutput(error: false, output: null),
    'banner': ValidationOutput(error: false, output: null),
  };

  Map<String, ValidationOutput> get validationOutputs => _validationOutputs;

  void setValidationOutput(
    String fieldName,
    ValidationOutput validationOutput,
  ) {
    _validationOutputs[fieldName] = validationOutput;
  }

  CrowdActionImages crowdActionImagesFactory() {
    return CrowdActionImages(
      card: _validationOutputs['card']!.output as Uint8List?,
      banner: _validationOutputs['banner']!.output as Uint8List?,
    );
  }
}
