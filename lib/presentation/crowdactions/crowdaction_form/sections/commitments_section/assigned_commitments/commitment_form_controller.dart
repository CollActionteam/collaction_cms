import 'package:collaction_cms/domain/core/value_validators.dart';

class CommitmentFormController {
  CommitmentFormController();

  List<ValidationOutput> validationOutputList = [];

  late ValidationOutput validationOutputTitle;
  late ValidationOutput validationOutputTags;
  ValidationOutput validationOutputDescription = ValidationOutput(error: false);
  late ValidationOutput validationOutputPoints;
  ValidationOutput validationOutputBlocks = ValidationOutput(error: false);
  late ValidationOutput validationOutputIcon;

  bool isReadyForBloc() {
    try {
      if (validationOutputTitle.error ||
          validationOutputTags.error ||
          validationOutputDescription.error ||
          validationOutputPoints.error ||
          validationOutputBlocks.error ||
          validationOutputIcon.error) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
