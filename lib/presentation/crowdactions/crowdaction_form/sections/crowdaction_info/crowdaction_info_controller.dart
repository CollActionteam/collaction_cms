import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';

class CrowdActionInfoFormController {
  CrowdActionInfoFormController();

  List<ValidationOutput> validationOutputList = [];

  late ValidationOutput validationOutputLabel;
  late ValidationOutput validationOutputCategory;
  ValidationOutput validationOutputSubcategory =
      ValidationOutput(error: false, output: null);
  late ValidationOutput validationOutputCountry;
  late ValidationOutput validationOutputDescription;
  ValidationOutput validationOutputPassword =
      ValidationOutput(error: false, output: null);
  late ValidationOutput validationOutputStartDate;
  late ValidationOutput validationOutputEndDate;
  ValidationOutput validationOutputJoinEndAt =
      ValidationOutput(error: false, output: null);
  late bool isItReadyForBlocBool = false;

  bool isReadyForBloc() {
    try {
      if (validationOutputLabel.error ||
          validationOutputCategory.error ||
          validationOutputSubcategory.error ||
          validationOutputCountry.error ||
          validationOutputDescription.error ||
          validationOutputPassword.error ||
          validationOutputStartDate.error ||
          validationOutputEndDate.error ||
          validationOutputJoinEndAt.error) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
