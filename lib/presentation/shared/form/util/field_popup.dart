import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

List<Widget> fieldPopup(
  Widget child, {
  Function? onTapOutside,
  required double width,
  required double height,
  required double offset,
}) {
  return [
    Positioned(
      left: -1920,
      top: -1080,
      width: 3840,
      height: 2160,
      child: DeferPointer(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (_) => onTapOutside!(),
          child: const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    ),
    Positioned(
      top: offset,
      width: width,
      height: height,
      child: DeferPointer(
        paintOnTop: true,
        child: Material(
          elevation: 5.0,
          color: Colors.white,
          shadowColor: Colors.black,
          //child: CollActionDatePicker(),
          child: child,
        ),
      ),
    )
  ];
}
