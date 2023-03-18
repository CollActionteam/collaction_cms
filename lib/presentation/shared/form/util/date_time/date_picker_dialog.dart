import 'package:flutter/material.dart';

import '../../../../theme/constants.dart';

class CollActionDatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime? earliestDate;
  final DateTime? latestDate;
  final Function(DateTime)? onDateSelected;
  final Function()? onCancel;

  const CollActionDatePicker({
    super.key,
    this.selectedDate,
    this.earliestDate,
    this.latestDate,
    this.onDateSelected,
    this.onCancel,
  });

  @override
  State<CollActionDatePicker> createState() => _CollActionDatePickerState();
}

class _CollActionDatePickerState extends State<CollActionDatePicker> {
  late DateTime? _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: kAccentHoverColor,
          onPrimary: Colors.white,
          onSurface: kBlackPrimary400,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: CalendarDatePicker(
              initialDate: widget.selectedDate ?? DateTime.now(),
              firstDate: widget.earliestDate ?? DateTime.now(),
              lastDate: widget.latestDate ?? DateTime(DateTime.now().year + 10),
              onDateChanged: (DateTime dateTime) => _dateTime = dateTime,
            ),
          ),
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
                  _dateTime ??= DateTime.now();
                  widget.onDateSelected!(_dateTime!);
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
}
