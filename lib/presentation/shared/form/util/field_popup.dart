import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

Widget fieldPopup(
  Widget child, {
  Function? onTapOutside,
  required double width,
  required double height,
  required double offset,
}) {
  return Positioned(
    top: offset,
    width: width,
    height: height,
    child: DeferPointer(
      paintOnTop: true,
      child: Material(
        elevation: 5.0,
        color: Colors.white,
        shadowColor: Colors.black,
        child: TapRegion(
          child: child,
          onTapOutside: (event) => onTapOutside!(),
        ),
      ),
    ),
  );
}
