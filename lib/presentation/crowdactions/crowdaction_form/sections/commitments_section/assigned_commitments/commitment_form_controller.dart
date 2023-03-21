import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:uuid/uuid.dart';

class CommitmentFormController {
  CommitmentFormController();

  List<ValidationOutput> validationOutputList = [];

  late ValidationOutput validationOutputTitle;
  late ValidationOutput validationOutputTags;
  ValidationOutput validationOutputDescription = ValidationOutput(error: false);
  late ValidationOutput validationOutputPoints;
  late ValidationOutput validationOutputIcon;

  bool isReadyForBloc() {
    try {
      if (validationOutputTitle.error ||
          validationOutputTags.error ||
          validationOutputDescription.error ||
          validationOutputPoints.error ||
          validationOutputIcon.error) {
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
      id: const Uuid().toString(),
      tags: validationOutputTags.output as List<String>,
      label: validationOutputTitle.output as String,
      points: validationOutputPoints.output as int,
      blocks: <String>[],
    );
  }
}
