import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:tap_canvas/tap_canvas.dart';

Widget fieldPopup(
  Widget child, {
  Function? onTapOutside,
  required Rect rect,
}) {
  return Positioned(
    top: rect.top,
    left: rect.left,
    width: rect.width,
    height: rect.height,
    child: DeferPointer(
      paintOnTop: true,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        elevation: 5.0,
        color: Colors.white,
        shadowColor: Colors.black,
        child: TapOutsideDetectorWidget(
          child: child,
          onTappedOutside: () => onTapOutside!(),
        ),
      ),
    ),
  );
}
