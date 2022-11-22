import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  fontFamily: "Rubik",
  scaffoldBackgroundColor: kScaffoldColorWhite,
  textSelectionTheme:
      const TextSelectionThemeData(selectionColor: kSelectionColor),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        brightness: Brightness.light,
        background: kScaffoldColorWhite,
        primary: kPrimaryColor,
        secondary: kAccentColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
