import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

ButtonStyle formFieldButtonStyle(
    {bool readOnly = false,
    double height = 32,
    Color backgroundColor = Colors.transparent}) {
  return ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        side: const BorderSide(color: Color(0x80707070)),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      readOnly ? kBlackPrimary0 : backgroundColor,
    ),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(
        double.infinity,
        height,
      ),
    ),
    mouseCursor: MaterialStateProperty.all<MouseCursor>(
      readOnly ? SystemMouseCursors.basic : SystemMouseCursors.click,
    ),
    overlayColor: MaterialStateProperty.all(const Color(0x08000000)),
  );
}
