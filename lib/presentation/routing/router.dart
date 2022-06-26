import 'package:collaction_admin/presentation/admin_moderation/admin_moderation_page.dart';
import 'package:collaction_admin/presentation/authentication/authentication_page.dart';
import 'package:collaction_admin/presentation/crowdactions/crowdactions_page.dart';
import 'package:collaction_admin/presentation/dashboard/dashboard_page.dart';
import 'package:collaction_admin/presentation/moderation_queue/moderation_queue_page.dart';
import 'package:collaction_admin/presentation/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case authenticationPageRoute:
      return _getRoute(const AuthenticationPage());
    case dashboardPageRoute:
      return _getRoute(const DashboardPage());
    case crowdActionPageRoute:
      return _getRoute(const CrowdActionPage());
    case moderationQueuePageRoute:
      return _getRoute(const ModerationQueuePage());
    case adminModerationPageRoute:
      return _getRoute(const AdminModerationPage());
    default:
      return _getRoute(const DashboardPage());
  }
}

PageRouteBuilder<dynamic> _getRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
