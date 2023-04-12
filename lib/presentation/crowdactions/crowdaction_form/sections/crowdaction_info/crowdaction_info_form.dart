import 'dart:async';

import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/shared/form/country_field.dart';
import 'package:collaction_cms/presentation/shared/form/date_time_form_field.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/crowdaction_info/crowdaction_info_controller.dart';
import 'package:collaction_cms/presentation/shared/form/form_header.dart';
import 'package:collaction_cms/presentation/shared/form/text_form_field.dart';
import 'package:flutter/cupertino.dart';

class CrowdActionInfoForm extends StatefulWidget {
  final double width;
  final bool buttonTriggered;
  final bool isFullWidth;
  final CrowdActionInfoFormController controller;

  const CrowdActionInfoForm({
    super.key,
    this.width = double.infinity,
    this.buttonTriggered = false,
    this.isFullWidth = false,
    required this.controller,
  });

  @override
  State<CrowdActionInfoForm> createState() => _CrowdActionInfoFormState();
}

class _CrowdActionInfoFormState extends State<CrowdActionInfoForm> {
  late Timer _everySecond;
  Timer? _everyMinute;
  String? title;
  late DateTime startDate;
  bool startDateSet = false;
  late DateTime endDate;
  bool endDateSet = false;
  DateTime? joinByDate;
  bool joinByDateSet = false;
  late Location country;
  late String description;
  late String category;
  String? subcategory;
  String? password;

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now()
        .copyWith(
          second: 0,
          millisecond: 0,
          microsecond: 0,
        )
        .add(const Duration(minutes: 5));
    endDate = startDate.add(const Duration(minutes: 1));
    joinByDate = startDate;

    _everySecond = Timer.periodic(const Duration(seconds: 1), (_) {
      var now = DateTime.now();
      if (now.second == 0) {
        _onMinuteChange();
        _everyMinute = Timer.periodic(
            const Duration(minutes: 1), (Timer t) => _onMinuteChange());
        _everySecond.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _everySecond.cancel();
    _everyMinute?.cancel();
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
            alignment: Alignment.topLeft,
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
                      validationCallback: validateEmptyField,
                      buttonTriggered: widget.buttonTriggered,
                      callback: (ValidationOutput validationOutput) {
                        widget.controller.validationOutputLabel =
                            validationOutput;
                      },
                    ),
                    CollactionTextFormField(
                      label: "Category",
                      width: halfWidth,
                      validationCallback: validateEmptyField,
                      buttonTriggered: widget.buttonTriggered,
                      callback: (ValidationOutput validationOutput) {
                        widget.controller.validationOutputCategory =
                            validationOutput;
                      },
                    ),
                    CollactionTextFormField(
                      label: "Subcategory",
                      width: halfWidth,
                      buttonTriggered: widget.buttonTriggered,
                      callback: (ValidationOutput validationOutput) {
                        widget.controller.validationOutputSubcategory =
                            validationOutput;
                      },
                    ),
                    CollactionDateTimeFormField(
                      label: "Start date",
                      width: widget.isFullWidth ? fullWidth : halfWidth,
                      selectedDate: startDate,
                      earliestDate:
                          DateTime.now().add(const Duration(minutes: 5)),
                      latestDate: endDateSet
                          ? endDate.subtract(const Duration(minutes: 1))
                          : null,
                      validationCallback: validateIncompleteDateTimeField,
                      callback: (ValidationOutput validationOutput,
                          DateTime dateTime) {
                        widget.controller.validationOutputStartDate =
                            validationOutput;
                        startDate = dateTime;
                        startDateSet = true;
                        setState(() {});
                      },
                      buttonTriggered: widget.buttonTriggered,
                      isFullWidth: widget.isFullWidth,
                    ),
                    CollactionDateTimeFormField(
                      label: "End date",
                      width: widget.isFullWidth ? fullWidth : halfWidth,
                      selectedDate: endDate,
                      earliestDate: _getEarliestEndDateTime(),
                      validationCallback:
                          validateIncompleteDateTimeField, // not required
                      callback: (ValidationOutput validationOutput,
                          DateTime dateTime) {
                        widget.controller.validationOutputEndDate =
                            validationOutput;
                        endDate = dateTime;
                        endDateSet = true;
                        setState(() {});
                      },
                      buttonTriggered: widget.buttonTriggered,
                      isFullWidth: widget.isFullWidth,
                    ),
                    CollactionDateTimeFormField(
                      label: "Join end at",
                      width: widget.isFullWidth ? fullWidth : halfWidth,
                      selectedDate: joinByDate,
                      earliestDate:
                          DateTime.now().add(const Duration(minutes: 5)),
                      latestDate: endDateSet
                          ? endDate.subtract(const Duration(minutes: 1))
                          : null,
                      callback: (ValidationOutput validationOutput,
                          DateTime dateTime) {
                        widget.controller.validationOutputJoinEndAt =
                            validationOutput;
                        joinByDate = dateTime;
                        joinByDateSet = true;
                        setState(() {});
                      },
                      buttonTriggered: widget.buttonTriggered,
                      isFullWidth: widget.isFullWidth,
                    ),
                    CollActionCountryField(
                      label: "Country",
                      width: widget.isFullWidth ? fullWidth : halfWidth,
                      buttonTriggered: widget.buttonTriggered,
                      validationCallback: validateEmptyField,
                      callback: (ValidationOutput validationOutput) {
                        widget.controller.validationOutputCountry =
                            validationOutput;
                      },
                    ),
                    CollactionTextFormField(
                      label: "Description",
                      width: fullWidth,
                      multiLine: true,
                      buttonTriggered: widget.buttonTriggered,
                      validationCallback: validateEmptyField,
                      callback: (ValidationOutput validationOutput) {
                        widget.controller.validationOutputDescription =
                            validationOutput;
                      },
                    ),
                    CollactionTextFormField(
                      label: "Password",
                      width: fullWidth,
                      buttonTriggered: widget.buttonTriggered,
                      callback: (ValidationOutput validationOutput) {
                        widget.controller.validationOutputPassword =
                            validationOutput;
                      },
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

  DateTime _getEarliestEndDateTime() {
    if (!startDateSet && !joinByDateSet) {
      return DateTime.now().add(const Duration(minutes: 6));
    }

    return startDate.compareTo(joinByDate!) > 0
        ? startDate.add(const Duration(minutes: 1))
        : joinByDate!.add(const Duration(minutes: 1));
  }

  void _onMinuteChange() {
    var now = DateTime.now().add(const Duration(minutes: 5));
    if (startDate.compareTo(now) < 0) {
      startDate = now;
    }
    if (joinByDate!.compareTo(now) < 0) {
      joinByDate = now;
    }
    now = now.add(const Duration(minutes: 1));
    if (endDate.compareTo(now) < 0) {
      endDate = now;
    }
    setState(() {});
  }
}
