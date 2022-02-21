import 'package:collaction_admin/presentation/theme/constants.dart';

import 'package:flutter/material.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: kScaffoldColor,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        brightness: Brightness.light,
        background: kScaffoldColor,
        primary: kPrimaryColor,
        secondary: kAccentColor,
      ),
  textTheme: ThemeData.light().textTheme,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
