import 'package:collaction_admin/infrastructure/core/injection.dart';
import 'package:collaction_admin/infrastructure/authentication/auth_repository.dart';
import 'package:collaction_admin/presentation/globals/keys.dart';
import 'package:collaction_admin/presentation/layout/page_layout.dart';
import 'package:collaction_admin/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:collaction_admin/application/authentication/authentication_bloc.dart';

import './presentation/go_routing/go_routing.dart';
import './application/navigation/navigation_bloc.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  var authenticationRepository = getIt<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthenticationBloc(authenticationRepository)),
          BlocProvider(create: (context) => getIt<NavigationBloc>())
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if(state is Authenticated) {
                  BlocProvider.of<NavigationBloc>(context).add(NavigateToPageEvent(route: "/admin/dashboard"));
                }
                if(state is Unauthenticated) {
                  BlocProvider.of<NavigationBloc>(context).add(NavigateToPageEvent(route: "/log-in"));
                }
                if(state is Unknown) {
                  BlocProvider.of<NavigationBloc>(context).add(NavigateToPageEvent(route: "/"));
                }
              },
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              routeInformationProvider: router.routeInformationProvider,
              title: 'CMS admin',
              theme: appTheme,
            ),
        ));
  }
}

