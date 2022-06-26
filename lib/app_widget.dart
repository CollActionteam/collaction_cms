import 'package:collaction_admin/application/authentication/authentication_bloc.dart';
import 'package:collaction_admin/infrastructure/core/injection.dart';
import 'package:collaction_admin/presentation/authentication/authentication_page.dart';
import 'package:collaction_admin/presentation/layout/page_layout.dart';
import 'package:collaction_admin/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AdminCMS',
      theme: appTheme,
      home: BlocProvider<AuthenticationBloc>(
        create: (context) =>
            getIt<AuthenticationBloc>()..add(AuthCheckRequested()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
              return const AuthenticationPage();
            }

            return const PageLayout();
          },
        ),
      ),
    );
  }
}
