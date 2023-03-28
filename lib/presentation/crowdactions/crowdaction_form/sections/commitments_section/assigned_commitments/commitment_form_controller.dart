import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class CommitmentFormController with ChangeNotifier {
  CommitmentFormController();

  String? _id;

  final Map<String, ValidationOutput?> _validationOutputs = {
    'title': null,
    'tags': null,
    'description': ValidationOutput(error: false),
    'points': null,
    'icon': null
  };

  String? get id => _id;

  void setId(String id) {
    _id = id;
  }

  Map<String, ValidationOutput?> get validationOutputs => _validationOutputs;

  void setValidationOutput(
      String fieldName, ValidationOutput validationOutput) {
    _validationOutputs[fieldName] = validationOutput;
    bool verificationCompleted = true;

    for (var value in _validationOutputs.values) {
      if (value == null) {
        verificationCompleted = false;
      }
    }

    /// HERE IS THE PROBLEM:
    if (verificationCompleted) {
      notifyListeners();
    }
  }

  /// the [skipInitialValidation] is used only to handle edge cases. In the commitmentItem a validation is needed before the child widget is
  /// "attached" to the widget tree. The status checker needs to handle the logic of the commitment form child before the lifetime of the children.
  /// If you want to bypass this you can use skipInitialValidation. In the context of [AssignedCommitments] makes sense because
  /// all the commitments that are already assigned have a correct initial values, since they passed [AssignCommitment] validation.
  bool isReadyForBloc([bool skipInitialValidation = false]) {
    if (skipInitialValidation == true) {
      try {
        if (_validationOutputs["title"]!.error ||
            _validationOutputs["tags"]!.error ||
            _validationOutputs["description"]!.error ||
            _validationOutputs["points"]!.error ||
            _validationOutputs["icon"]!.error) {
          return false;
        } else {
          return true;
        }
      } catch (e) {
        return true;
      }
    }

    try {
      if (_validationOutputs["title"]!.error ||
          _validationOutputs["tags"]!.error ||
          _validationOutputs["description"]!.error ||
          _validationOutputs["points"]!.error ||
          _validationOutputs["icon"]!.error) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Commitment commitmentFactory() {
    return Commitment(
      id: _id ?? const Uuid().v4(),
      iconId: _validationOutputs["icon"]!.output as String,
      description: _validationOutputs["description"]!.output as String,
      tags: _validationOutputs["tags"]!.output as List<String>,
      label: _validationOutputs["title"]!.output as String,
      points: _validationOutputs["points"]!.output as int,
      blocks: <String>[],
    );
  }
}
