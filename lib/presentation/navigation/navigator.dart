import 'package:collaction_admin/presentation/routing/router.dart';
import 'package:collaction_admin/presentation/routing/routes.dart';
import 'package:flutter/material.dart';

class LocalNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const LocalNavigator({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: dashboardPageRoute,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
