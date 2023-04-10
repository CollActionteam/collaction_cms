import 'package:collaction_cms/presentation/shared/form/util/date_time/date_picker_dialog.dart';
import 'package:collaction_cms/presentation/shared/form/util/field_popup.dart';
import 'package:collaction_cms/presentation/theme/button.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerButton extends StatefulWidget {
  final double width;
  final Rect? popupRect;
  final Function(DateTime)? callback;
  final DateTime? selectedDate;
  final DateTime? earliestDate;
  final DateTime? latestDate;
  final bool readOnly;

  const DatePickerButton({
    super.key,
    required this.width,
    this.popupRect,
    this.callback,
    this.selectedDate,
    this.earliestDate,
    this.latestDate,
    this.readOnly = true,
  });

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  bool _showOverlay = false;
  bool _dateSet = false;

  @override
  void initState() {
    super.initState();
  }

  void _closeDatePicker() {
    setState(() {
      _showOverlay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Stack(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                if (!widget.readOnly) {
                  _showOverlay = !_showOverlay;
                }
              });
            },
            style: formFieldButtonStyle(readOnly: widget.readOnly),
            child: Row(
              children: [
                SizedBox(
                  width: widget.width - 31.5,
                  child: Text(
                    _dateSet
                        ? DateFormat('dd/MM/yyyy').format(widget.selectedDate!)
                        : "DD/MM/YYYY",
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w300,
                      color: kBlackPrimary300,
                      fontSize: 15,
                    ),
                    softWrap: false,
                  ),
                ),
                const Icon(
                  Icons.calendar_month,
                  size: 15.5,
                  color: Color(0xFF707070),
                ),
              ],
            ),
          ),
          if (_showOverlay)
            fieldPopup(
              CollActionDatePicker(
                selectedDate: widget.selectedDate,
                earliestDate: widget.earliestDate,
                latestDate: widget.latestDate,
                onDateSelected: (DateTime dateTime) {
                  widget.callback!(dateTime);
                  _dateSet = true;
                },
                onCancel: _closeDatePicker,
              ),
              rect: widget.popupRect ?? const Rect.fromLTWH(0, 0, 280, 300),
              onTapOutside: _closeDatePicker,
            ),
        ],
      ),
    );
  }
}
