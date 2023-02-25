import 'package:collaction_cms/presentation/shared/form/util/number_field.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CollActionTimePicker extends StatefulWidget {
  final DateTime? selectedTime;
  final DateTime? earliestTime;
  final DateTime? latestTime;
  final Function(DateTime)? onTimeSelected;
  final Function()? onCancel;
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController hourController = TextEditingController();

  CollActionTimePicker({
    super.key,
    this.selectedTime,
    this.earliestTime,
    this.latestTime,
    this.onTimeSelected,
    this.onCancel,
  });

  @override
  State<CollActionTimePicker> createState() => _CollActionTimePickerState();
}

class _CollActionTimePickerState extends State<CollActionTimePicker> {
  late DateTime _time;
  TimeOfDay _earliestTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _latestTime = const TimeOfDay(hour: 23, minute: 59);

  final NumberFormat formatter = NumberFormat("00");

  @override
  void initState() {
    super.initState();
    _time = widget.selectedTime == null
        ? DateTime.now().copyWith(hour: 0, minute: 0)
        : widget.selectedTime!;

    if (widget.earliestTime != null && _time.isSameDate(widget.earliestTime!)) {
      _earliestTime = TimeOfDay.fromDateTime(widget.earliestTime!);
    }

    if (widget.latestTime != null && _time.isSameDate(widget.latestTime!)) {
      _latestTime = TimeOfDay.fromDateTime(widget.latestTime!);
    }

    _validateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: kAccentHoverColor,
          onPrimary: Colors.white,
          onSurface: kBlackPrimary300,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 30,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Time",
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 75,
                child: NumberField(
                  label: "Hour",
                  controller: widget.hourController,
                  onChanged: (int hour) {
                    _validateTime(hour: hour);
                    setState(() {});
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                width: 20,
                child: const Text(
                  ":",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: kBlackPrimary300,
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                height: 75,
                child: NumberField(
                  label: "Minute",
                  controller: widget.minuteController,
                  onChanged: (int minute) {
                    _validateTime(minute: minute);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ButtonBar(
            children: [
              TextButton(
                onPressed: widget.onCancel,
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(color: Color(0xFF707070)),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onTimeSelected!(_time);
                  widget.onCancel!();
                },
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: const Text(
                  "OK",
                  style: TextStyle(color: Color(0xFF707070)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _validateTime({int hour = -1, int minute = -1}) {
    if (hour < 0) hour = _time.hour;
    if (hour > 23) hour = 23;
    if (minute < 0) minute = _time.minute;
    if (minute > 59) minute = 59;
    if (hour * 60 + minute >= _latestTime.hour * 60 + _latestTime.minute) {
      hour = _latestTime.hour;
      minute = _latestTime.minute;
    }
    if (hour * 60 + minute <= _earliestTime.hour * 60 + _earliestTime.minute) {
      hour = _earliestTime.hour;
      minute = _earliestTime.minute;
    }
    _time = _time.copyWith(hour: hour, minute: minute);
    widget.hourController.text = formatter.format(hour);
    widget.minuteController.text = formatter.format(minute);
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
