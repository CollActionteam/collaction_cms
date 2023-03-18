import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../theme/button.dart';
import '../../../../theme/constants.dart';
import '../field_popup.dart';
import 'time_picker.dart';

class TimePickerButton extends StatefulWidget {
  final double width;
  final Function? callback;
  final DateTime? selectedTime;
  final DateTime? earliestTime;
  final DateTime? latestTime;
  final bool readOnly;

  const TimePickerButton({
    super.key,
    required this.width,
    this.callback,
    this.selectedTime,
    this.earliestTime,
    this.latestTime,
    this.readOnly = false,
  });

  @override
  State<TimePickerButton> createState() => _TimePickerButtonState();
}

class _TimePickerButtonState extends State<TimePickerButton> {
  bool _timeSet = false;
  bool _showOverlay = false;

  void _closeTimePicker() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Stack(
        children: [
          IgnorePointer(
            ignoring: widget.readOnly,
            child: TextButton(
              onPressed: () {
                if (!widget.readOnly) {
                  setState(() {
                    _showOverlay = true;
                  });
                }
              },
              style: formFieldButtonStyle(readOnly: widget.readOnly).copyWith(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: widget.width,
                    child: Text(
                      _timeSet
                          ? DateFormat.Hm().format(widget.selectedTime!)
                          : "--:--",
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: kBlackPrimary300,
                        fontSize: 15,
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showOverlay)
            fieldPopup(
              CollActionTimePicker(
                selectedTime: widget.selectedTime,
                earliestTime: widget.earliestTime,
                latestTime: widget.latestTime,
                onTimeSelected: (DateTime dateTime) {
                  _timeSet = true;
                  widget.callback!(dateTime);
                },
                onCancel: _closeTimePicker,
              ),
              height: 174,
              width: 220,
              offset: 0,
              onTapOutside: _closeTimePicker,
            ),
        ],
      ),
    );
  }
}
