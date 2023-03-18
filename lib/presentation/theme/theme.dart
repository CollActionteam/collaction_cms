import 'package:flutter/material.dart';

import 'constants.dart';

final appTheme = ThemeData(
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
