import 'package:flutter/material.dart';

import 'constants.dart';

ButtonStyle formFieldButtonStyle({
  bool readOnly = false,
  double height = 32,
}) {
  return ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        side: const BorderSide(color: Color(0x80707070)),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      readOnly ? kBlackPrimary0 : Colors.transparent,
    ),
    fixedSize: MaterialStateProperty.all<Size>(
      Size(double.infinity, height),
    ),
    mouseCursor: MaterialStateProperty.all<MouseCursor>(
      readOnly ? SystemMouseCursors.basic : SystemMouseCursors.click,
    ),
    overlayColor: MaterialStateProperty.all(const Color(0x08000000)),
  );
}
