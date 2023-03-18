import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/navigation/navigation_bloc.dart';
import '../auth/authentication_page.dart';
import '../auth/create_credentials.dart';
import '../auth/link_auth_page.dart';
import '../crowdactions/crowdaction_view/crowdaction_view.dart';
import '../crowdactions/crowdactions_page.dart';
import '../dashboard/dashboard_page.dart';
import '../layout/loader.dart';
import '../layout/page_layout.dart';
import '../moderation_queue/moderation_queue_page.dart';
import 'listenables.dart';

GoRouter getRouter(BuildContext context) {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  final router = GoRouter(
      navigatorKey: rootNavigatorKey,
      redirect: (context, state) {
        if (state.location !=
            BlocProvider.of<NavigationBloc>(context).state.route) {
          return BlocProvider.of<NavigationBloc>(context).state.route;
        }

        return null;
      },
      routes: [
        GoRoute(
            path: '/',
            name: 'loading',
            pageBuilder: ((context, state) {
              return const MaterialPage(child: Loader());
            })),
        GoRoute(
          path: '/verification',
          name: 'verification',
          pageBuilder: (context, state) {
            return const MaterialPage(child: LinkAuthPage());
          },
        ),
        GoRoute(
            path: '/create-credentials',
            name: 'create-credentials',
            pageBuilder: ((context, state) {
              return const MaterialPage(child: CreateCredentialsPage());
            })),
        GoRoute(
            path: '/log-in',
            name: 'log-in',
            pageBuilder: ((context, state) {
              return const MaterialPage(child: AuthenticationPage());
            })),
        ShellRoute(
            navigatorKey: shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return PageLayout(
                child: child,
              );
            },
            routes: <RouteBase>[
              GoRoute(
                  path: '/cms/dashboard',
                  name: 'dashboard',
                  builder: (BuildContext context, GoRouterState state) {
                    return const DashboardPage();
                  }),
              GoRoute(
                  path: '/cms/crowdactions',
                  name: 'crowdactions',
                  builder: ((BuildContext context, GoRouterState state) {
                    return const CrowdActionsPage();
                  })),
              GoRoute(
                  path: '/cms/crowdaction',
                  builder: (BuildContext context, GoRouterState state) {
                    return CrowdActionPage();
                  }),
              GoRoute(
                path: '/cms/moderation-queue',
                name: 'moderation-queue',
                builder: (context, state) {
                  return const ModerationQueuePage();
                },
              )
            ])
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const Scaffold(
              body: Center(
            child: Text("404"),
          )),
        );
      },
      refreshListenable: GoRouterRefreshStream(
          BlocProvider.of<NavigationBloc>(context).stream));
  return router;
}
