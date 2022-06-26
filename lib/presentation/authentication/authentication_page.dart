import 'package:collaction_admin/application/authentication/authentication_bloc.dart';
import 'package:collaction_admin/presentation/layout/responsiveness.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: ResponsiveWidget(
        largeScreen: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: 275,
                width: constraints.maxWidth * 0.4,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16.0),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            focusedBorder: UnderlineInputBorder(),
                            border: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(),
                            floatingLabelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            focusedBorder: UnderlineInputBorder(),
                            border: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.black),
                            floatingLabelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () =>
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(
                                  SignInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kAccentColor),
                                ),
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
