import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/form/form_field.dart';
import 'package:collaction_cms/presentation/shared/form/util/date_time/date_picker_button.dart';
import 'package:collaction_cms/presentation/shared/form/util/date_time/time_picker_button.dart';
import 'package:flutter/material.dart';

class CollactionDateTimeFormField extends StatefulWidget {
  final String? label;
  final double width;
  final Function? callback;
  final Function? validationCallback;
  final bool readOnly;
  final DateTime? selectedDate;
  final DateTime? earliestDate;
  final DateTime? latestDate;
  final bool buttonTriggered;

  const CollactionDateTimeFormField({
    super.key,
    this.label,
    this.width = double.infinity,
    this.callback,
    this.validationCallback,
    this.readOnly = false,
    this.selectedDate,
    this.earliestDate,
    this.latestDate,
    this.buttonTriggered = false,
  });

  @override
  State<CollactionDateTimeFormField> createState() =>
      _CollactionDateTimeFormFieldState();
}

class _CollactionDateTimeFormFieldState
    extends State<CollactionDateTimeFormField> {
  late ValidationOutput _validationOutput;
  late DateTime _dateTime;
  bool _dateSet = false;
  bool _timeSet = false;

  @override
  Widget build(BuildContext context) {
    _dateTime = _getCurrentDateTime();
    _validateDateTime();
    return CollActionFormField(
      readOnly: widget.readOnly,
      error: widget.buttonTriggered && _validationOutput.error
          ? _validationOutput.output
          : null,
      label: widget.label,
      width: widget.width,
      child: SizedBox(
        height: 32,
        child: Row(
          children: [
            DatePickerButton(
              readOnly: widget.readOnly,
              width: widget.width * 0.67,
              selectedDate: _dateTime,
              earliestDate: widget.earliestDate,
              latestDate: widget.latestDate,
              callback: (DateTime dateTime) {
                setState(() {
                  _dateTime = dateTime.copyWith(
                      hour: _timeSet ? _dateTime.hour : 0,
                      minute: _timeSet ? _dateTime.minute : 0);
                  _dateSet = true;
                  _validateDateTime();
                  widget.callback!(_validationOutput, _dateTime);
                });
              },
            ),
            const SizedBox(width: 4),
            TimePickerButton(
              readOnly: widget.readOnly || !_dateSet,
              width: widget.width * 0.33 - 4,
              selectedTime: _dateTime,
              earliestTime: widget.earliestDate,
              latestTime: widget.latestDate,
              callback: (DateTime dateTime) {
                setState(() {
                  _dateTime = dateTime;
                  _timeSet = true;
                  _validateDateTime();
                  widget.callback!(_validationOutput, _dateTime);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  DateTime _getCurrentDateTime() {
    return _dateSet
        ? widget.selectedDate!
        : widget.earliestDate ??
            DateTime.now().copyWith(hour: 0, minute: 0, second: 0);
  }

  void _validateDateTime() {
    widget.validationCallback == null
        ? _dateSet && _timeSet
            ? _validationOutput = ValidationOutput(
                error: false,
                output: _dateTime,
              )
            : _validationOutput = ValidationOutput(error: false, output: null)
        : _validationOutput = widget.validationCallback!(
            _dateTime,
            _dateSet,
            _timeSet,
          );

    if (widget.latestDate != null &&
        _dateTime.compareTo(widget.latestDate!) > 0) {
      _dateTime = widget.latestDate!;
    }

    if (widget.earliestDate != null &&
        _dateTime.compareTo(widget.earliestDate!) < 0) {
      _dateTime = widget.earliestDate!;
    }
  }
}
