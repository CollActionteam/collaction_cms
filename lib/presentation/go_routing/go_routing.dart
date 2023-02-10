import 'package:collaction_cms/presentation/auth/authentication_page.dart';
import 'package:collaction_cms/presentation/auth/create_credentials.dart';
import 'package:collaction_cms/presentation/auth/link_auth_page.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdactions_page.dart';
import 'package:collaction_cms/presentation/dashboard/dashboard_page.dart';
import 'package:collaction_cms/presentation/go_routing/listenables.dart';
import 'package:collaction_cms/presentation/layout/loader.dart';
import 'package:collaction_cms/presentation/layout/page_layout.dart';
import 'package:collaction_cms/presentation/moderation_queue/moderation_queue_page.dart';
import 'package:collaction_cms/application/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                  path: '/admin/dashboard',
                  name: 'dashboard',
                  builder: (BuildContext context, GoRouterState state) {
                    return const DashboardPage();
                  }),
              GoRoute(
                  path: '/admin/crowdaction',
                  name: 'crowdaction',
                  builder: ((BuildContext context, GoRouterState state) {
                    return const CrowdActionPage();
                  })),
              GoRoute(
                path: '/admin/moderation-queue',
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
