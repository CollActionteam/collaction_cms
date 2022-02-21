import 'package:collaction_admin/presentation/admin_moderation/admin_moderation_page.dart';
import 'package:collaction_admin/presentation/crowdactions/crowdactions_page.dart';
import 'package:collaction_admin/presentation/dashboard/dashboard_page.dart';
import 'package:collaction_admin/presentation/moderation_queue/moderation_queue_page.dart';
import 'package:collaction_admin/presentation/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
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

PageRoute _getRoute(Widget child) {
  return MaterialPageRoute(builder: (_) => child);
}
