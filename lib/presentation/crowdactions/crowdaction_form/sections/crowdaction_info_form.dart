import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/shared/form/country_field.dart';
import 'package:collaction_cms/presentation/shared/form/date_time_form_field.dart';
import 'package:collaction_cms/presentation/shared/form/form_header.dart';
import 'package:collaction_cms/presentation/shared/form/text_form_field.dart';
import 'package:flutter/cupertino.dart';

class CrowdActionInfoForm extends StatefulWidget {
  final double width;
  final bool buttonTriggered;

  const CrowdActionInfoForm({
    super.key,
    this.width = double.infinity,
    this.buttonTriggered = false,
  });

  @override
  State<CrowdActionInfoForm> createState() => _CrowdActionInfoFormState();
}

class _CrowdActionInfoFormState extends State<CrowdActionInfoForm> {
  String? title;
  String? type;
  late DateTime startDate;
  bool startDateSet = false;
  late DateTime endDate;
  bool endDateSet = false;
  late DateTime joinByDate;
  bool joinByDateSet = false;
  Location? country;
  String? description;
  String? category;
  String? subcategory;
  String? password;

  @override
  void initState() {
    super.initState();
    startDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    endDate = startDate.add(const Duration(minutes: 1));
    joinByDate = startDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const FormHeader(title: "Basic Information"),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                bool shrink = constraints.maxWidth < 405;
                double fullWidth = shrink ? constraints.maxWidth : 405;
                double halfWidth = shrink ? constraints.maxWidth : 192;
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 21,
                  children: [
                    CollactionTextFormField(
                      label: "Title of CrowdAction",
                      width: fullWidth,
                      validationCallback: validateEmptyTextField,
                      buttonTriggered: widget.buttonTriggered,
                    ),
                    CollactionTextFormField(
                      label: "Category",
                      width: halfWidth,
                      validationCallback: validateEmptyTextField,
                      buttonTriggered: widget.buttonTriggered,
                    ),
                    CollactionTextFormField(
                      label: "Subcategory",
                      width: halfWidth,
                      validationCallback: validateEmptyTextField,
                      buttonTriggered: widget.buttonTriggered,
                    ),
                    CollactionDateTimeFormField(
                      label: "Start date",
                      width: halfWidth,
                      selectedDate: startDate,
                      latestDate: endDateSet
                          ? endDate.subtract(const Duration(minutes: 1))
                          : null,
                      validationCallback: validateDateTimeField,
                      callback: (bool error, DateTime dateTime) {
                        startDate = dateTime;
                        startDateSet = true;
                        setState(() {});
                      },
                      buttonTriggered: widget.buttonTriggered,
                    ),
                    CollactionDateTimeFormField(
                      label: "End date",
                      width: halfWidth,
                      selectedDate: endDate,
                      earliestDate: startDate.compareTo(joinByDate) > 0
                          ? startDate.add(const Duration(minutes: 1))
                          : joinByDate.add(const Duration(minutes: 1)),
                      validationCallback: validateDateTimeField,
                      callback: (bool error, DateTime dateTime) {
                        endDate = dateTime;
                        endDateSet = true;
                        setState(() {});
                      },
                      buttonTriggered: widget.buttonTriggered,
                    ),
                    CollactionDateTimeFormField(
                      label: "Join end at",
                      width: halfWidth,
                      selectedDate: joinByDate,
                      latestDate: endDateSet
                          ? endDate.subtract(const Duration(minutes: 1))
                          : null,
                      validationCallback: validateDateTimeField,
                      callback: (bool error, DateTime dateTime) {
                        joinByDate = dateTime;
                        joinByDateSet = true;
                        setState(() {});
                      },
                      buttonTriggered: widget.buttonTriggered,
                    ),
                    CollActionCountryField(
                      label: "Country",
                      width: halfWidth,
                      buttonTriggered: widget.buttonTriggered,
                      validationCallback: validateCountryField,
                    ),
                    CollactionTextFormField(
                      label: "Description",
                      width: fullWidth,
                      multiLine: true,
                      buttonTriggered: widget.buttonTriggered,
                    ),
                    CollactionTextFormField(
                      label: "Password",
                      width: fullWidth,
                      validationCallback: validatePasswordSimple,
                      buttonTriggered: widget.buttonTriggered,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
