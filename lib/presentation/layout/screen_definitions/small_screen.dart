import 'package:collaction_admin/presentation/navigation/navigator.dart';
import 'package:collaction_admin/presentation/navigation/top_bar.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class SmallScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<NavigatorState> navigatorKey;

  const SmallScreen({
    Key? key,
    required this.scaffoldKey,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            color: kScaffoldColor,
            child: Column(
              children: [
                TopBar(isSmallScreen: true, scaffoldKey: scaffoldKey),
                Expanded(child: LocalNavigator(navigatorKey: navigatorKey)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
