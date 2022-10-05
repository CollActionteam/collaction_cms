import 'package:collaction_admin/infrastructure/core/injection.dart';
import 'package:collaction_admin/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collaction_admin/application/authentication/authentication_bloc.dart';

import './presentation/go_routing/go_routing.dart';
import './application/navigation/navigation_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthenticationBloc>(),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(),
          )
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigateToPageEvent(route: "/admin/dashboard"));
                }
                if (state is Unauthenticated) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigateToPageEvent(route: "/log-in"));
                }
                if (state is Unknown) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigateToPageEvent(route: "/"));
                }
              },
            ),
          ],
          child: Builder(
            builder: (context) {
              final goRouter = getRouter(context);

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routeInformationParser: goRouter.routeInformationParser,
                routerDelegate: goRouter.routerDelegate,
                routeInformationProvider: goRouter.routeInformationProvider,
                title: 'CollAction CMS',
                theme: appTheme,
              );
            },
          ),
        ));
  }
}
