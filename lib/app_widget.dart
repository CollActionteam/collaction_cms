import 'package:collaction_cms/application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import 'package:collaction_cms/application/crowdaction/pagination/pagination_cubit.dart';
import 'package:collaction_cms/infrastructure/core/injection.dart';
import 'package:collaction_cms/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collaction_cms/application/auth/auth_bloc.dart';

import './presentation/go_routing/go_routing.dart';
import './application/navigation/navigation_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthBloc>(),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider(
            create: (context) => getIt<CrowdActionGetterBloc>()..add(const CrowdActionGetterEvent.fetchCrowdActions(1, 2, null)),
          ),
          BlocProvider(
            create: (_) => getIt<PaginationCubit>()
          )
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                state.mapOrNull(unaunthenticated: (_) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigateToPageEvent(route: "/log-in"));
                }, authenticated: (_) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigateToPageEvent(route: "/admin/dashboard"));
                }, unknown: (_) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigateToPageEvent(route: "/"));
                }, onVerification: (value) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigateToPageEvent(route: value.pathname!));
                }, preAuthenticated: (value) {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigateToPageEvent(route: "/create-credentials"));
                },
                );
              },
            ),
          ],
          child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              final goRouter = getRouter(context);
              return BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  print(state);
                },
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routeInformationParser: goRouter.routeInformationParser,
                  routerDelegate: goRouter.routerDelegate,
                  routeInformationProvider: goRouter.routeInformationProvider,
                  title: 'CollAction CMS',
                  theme: appTheme,
                ),
              );
            },
          ),
        ));
  }
}
