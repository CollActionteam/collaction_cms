import 'package:collaction_admin/presentation/navigation/side_navigation.dart';
import 'package:collaction_admin/presentation/navigation/top_bar.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:flutter/material.dart';


class LargeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<NavigatorState> navigatorKey;

  const LargeScreen({
    Key? key,
    required this.scaffoldKey,
    required this.navigatorKey,
    required this.child
  }) : super(key: key);

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