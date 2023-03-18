import 'package:flutter/material.dart';

import '../../navigation/side_navigation.dart';
import '../../navigation/top_bar.dart';
import '../../theme/constants.dart';

class LargeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<NavigatorState> navigatorKey;

  const LargeScreen(
      {Key? key,
      required this.scaffoldKey,
      required this.navigatorKey,
      required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Navigation Menu
        const SideNavigation(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            color: kScaffoldColor,
            child: Column(
              children: [
                TopBar(scaffoldKey: scaffoldKey),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
