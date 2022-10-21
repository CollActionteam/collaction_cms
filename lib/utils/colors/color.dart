import 'package:flutter/material.dart';

enum ColorTypeModification { darken, brighten }

class ColorUtils {
  static Color modifyColor(Color colorInput,
      ColorTypeModification colorTypeModification, double lightnessAmount) {
    if (lightnessAmount > 0 || lightnessAmount < 1) {
      throw ("Lightness amount should be greater than 0 and less than 1");
    }

    final hsl = HSLColor.fromColor(colorInput);
    late HSLColor hslModified;
    if (colorTypeModification == ColorTypeModification.brighten) {
      hslModified = hsl.withLightness(hsl.lightness + lightnessAmount);
    }

    if (colorTypeModification == ColorTypeModification.darken) {
      hslModified = hsl.withLightness(hsl.lightness - lightnessAmount);
    }

    final colorOutput = hslModified.toColor();

    return colorOutput;
  }
}
