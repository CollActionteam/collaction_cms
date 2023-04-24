import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:flutter/material.dart';

class CrowdActionInfoFormController with ChangeNotifier {
  CrowdActionInfoFormController();

  final Map<String, ValidationOutput?> _validationOutputs = {
    'title': null,
    'startDate': null,
    'endDate': null,
    'joinEndAt': ValidationOutput(error: false, output: null),
    'country': null,
    'description': null,
    'category': null,
    'subcategory': ValidationOutput(error: false),
    'password': ValidationOutput(error: false),
  };

  Map<String, ValidationOutput?> get validationOutputs => _validationOutputs;

  void setValidationOutput(
    String fieldName,
    ValidationOutput validationOutput,
  ) {
    _validationOutputs[fieldName] = validationOutput;
    bool verificationCompleted = true;
    for (var value in _validationOutputs.values) {
      if (value == null) {
        verificationCompleted = false;
      }
    }

    if (verificationCompleted) {
      notifyListeners();
    }
  }

  bool isReadyForBloc() {
    for (var value in _validationOutputs.values) {
      if (value == null) {
        return false;
      } else if (value.error) {
        return false;
      }
    }

    return true;
  }

  CrowdActionInfo crowdActionInfoFactory() {
    return CrowdActionInfo(
      title: (_validationOutputs['title']!.output as String).trim(),
      startDate: _validationOutputs['startDate']!.output as DateTime,
      endDate: _validationOutputs['endDate']!.output as DateTime,
      joinEndAt: _validationOutputs['joinEndAt']!.output as DateTime?,
      country: _validationOutputs['country']!.output as Location,
      description: (_validationOutputs['description']!.output as String).trim(),
      category: (_validationOutputs['category']!.output as String).trim(),
      subcategory: _validationOutputs['subcategory']!.output as String?,
      password: _validationOutputs['password']!.output as String?,
    );
  }
}
