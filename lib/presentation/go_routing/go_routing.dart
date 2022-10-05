import 'package:collaction_admin/presentation/authentication/authentication_page.dart';
import 'package:collaction_admin/presentation/crowdactions/crowdactions_page.dart';
import 'package:collaction_admin/presentation/dashboard/dashboard_page.dart';
import 'package:collaction_admin/presentation/globals/keys.dart';
import 'package:collaction_admin/presentation/go_routing/listenables.dart';
import 'package:collaction_admin/presentation/layout/loader.dart';
import 'package:collaction_admin/presentation/layout/page_layout.dart';
import 'package:collaction_admin/presentation/moderation_queue/moderation_queue_page.dart';
import 'package:collaction_admin/application/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter getRouter(BuildContext context) => GoRouter(
    navigatorKey: GlobalKeys.rootNavigatorKey,
    redirect: (context, state) {
      if (state.location !=
          BlocProvider.of<NavigationBloc>(context).state.route) {
        BlocProvider.of<NavigationBloc>(context).state.route;
      }

      return;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'loading',
        pageBuilder: (context, state) => const MaterialPage(child: Loader()),
      ),
      GoRoute(
        path: '/log-in',
        name: 'log-in',
        pageBuilder: (context, state) =>
            const MaterialPage(child: AuthenticationPage()),
      ),
      ShellRoute(
        navigatorKey: GlobalKeys.shellNavigatorKey,
        builder: (context, state, child) {
          return PageLayout(
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
              path: '/admin/dashboard',
              name: 'dashboard',
              builder: (context, state) => const DashboardPage()),
          GoRoute(
            path: '/admin/crowdaction',
            name: 'crowdaction',
            builder: (context, state) => const CrowdActionPage(),
          ),
          GoRoute(
            path: '/admin/moderation-queue',
            name: 'moderation-queue',
            builder: (context, state) => const ModerationQueuePage(),
          )
        ],
      )
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: const Scaffold(
          body: Center(
            child: Text("404"),
          ),
        ),
      );
    },
    refreshListenable:
        GoRouterRefreshStream(BlocProvider.of<NavigationBloc>(context).stream));
