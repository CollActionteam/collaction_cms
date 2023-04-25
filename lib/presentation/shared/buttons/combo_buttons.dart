import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:flutter/material.dart';

class ComboButtonsOnOff extends StatefulWidget {
  final Function onOrOffCallback;
  final double height;
  final double width;
  final double fontSize;

  ComboButtonsOnOff({
    super.key,
    required this.onOrOffCallback,
    this.height = 35,
    this.width = 193,
    this.fontSize = 16,
  });

  @override
  State<ComboButtonsOnOff> createState() => _ComboButtonsOnOffState();
}

class _ComboButtonsOnOffState extends State<ComboButtonsOnOff> {
  bool onOrOff = false;
  ValueNotifier<bool> onOrOffNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onOrOffNotifier.addListener(() {
      widget.onOrOffCallback(onOrOffNotifier.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        CollActionButtonRectangle.wrapped(
          text: "Choose templates",
          onPressed: () => {
            setState(() {
              onOrOffNotifier.value = false;
            })
          },
          height: widget.height,
          width: widget.width,
          fontSize: widget.fontSize,
          inverted: onOrOffNotifier.value,
        ),
        const SizedBox(width: 14),
        CollActionButtonRectangle.wrapped(
          text: "Create from scratch",
          onPressed: () => {
            setState(() {
              onOrOffNotifier.value = true;
            })
          },
          height: widget.height,
          width: widget.width,
          fontSize: widget.fontSize,
          inverted: !onOrOffNotifier.value,
        )
      ],
    );
  }
}
