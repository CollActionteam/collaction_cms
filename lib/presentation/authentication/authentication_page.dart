import 'package:collaction_admin/application/auth/auth_bloc.dart';
import 'package:collaction_admin/domain/auth/value_validators.dart';
import 'package:collaction_admin/presentation/layout/responsiveness.dart';
import 'package:collaction_admin/presentation/shared/buttons/buttons.dart';
import 'package:collaction_admin/presentation/shared/form/input_field.dart';
import 'package:collaction_admin/presentation/shared/notifications/error.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool emailValidationError = true;
  bool passwordValidationError = true;
  bool buttonTriggered = false;

  bool authError = false;
  late String authErrorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        state.mapOrNull(
          authError: (value) {
            authError = true;
            authErrorMessage = value.failure.error;
          },
        );
        return Scaffold(
          body: ResponsiveWidget(
            largeScreen: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 40, bottom: 40, left: 5),
                    child: Image.asset(
                      'images/Vector.png',
                      width: 200,
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kLightBackgroundGreyColor,
                        ),
                        height: 493,
                        width: 374,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 6,
                          color: kLightBackgroundGreyColor,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 26.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(top: 32),
                                    alignment: Alignment.center,
                                    child: const SelectableText('Welcome',
                                        style: TextStyle(
                                            fontFamily: "Rubik",
                                            fontSize: 28,
                                            fontWeight: FontWeight.w700,
                                            color: kTextTitle))),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 8, right: 8),
                                  alignment: Alignment.center,
                                  child: const SelectableText(
                                      textAlign: TextAlign.center,
                                      'Please, enter your credentials to enter the CMS admin app.',
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontFamily: "Rubik",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                ),
                                const SizedBox(height: 10),
                                authError ? 
                                ErrorNotification(errorMessage: authErrorMessage,) : const SizedBox.shrink(),
                                const SizedBox(height: 15),
                                CollActionInputField(
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  labelText: "Email",
                                  buttonTriggered: buttonTriggered,
                                  callback: (value) {
                                    setState(() {
                                      emailValidationError = value;
                                    });
                                  },
                                  validationCallback: (value) {
                                    return validateEmailAddress(value);
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                CollActionInputField(
                                  password: true,
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  buttonTriggered: buttonTriggered,
                                  callback: (value) {
                                    setState(() {
                                      passwordValidationError = value;
                                    });
                                  },
                                  validationCallback: (value) {
                                    return validatePasswordSimple(value);
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                CollActionButton(
                                  loading: _isItLoading(state),
                                  onPressed: () {
                                    setState(() {
                                      buttonTriggered = true;
                                    });
                                    if (!emailValidationError &&
                                        !passwordValidationError) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          AuthEvent.signInWithEmailAndPassword(
                                              emailController.value.text,
                                              passwordController.value.text));
                                    }
                                    if (emailValidationError) return emailFocusNode.requestFocus();
                                      
                                    if (passwordValidationError) return passwordFocusNode.requestFocus();
                                    
                                  }
                                  // BlocProvider.of<AuthBloc>(context)
                                  //     .add(const AuthEvent.authCheckRequestedTest(
                                  //         AuthenticationStatus.authenticated)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isItLoading(AuthState state) {

    bool isItLoading = false;

    state.mapOrNull(
      signingInUser: ((value) {
        isItLoading = true;
      })
    );

    return isItLoading;
  }
}
