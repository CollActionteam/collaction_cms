import 'package:collaction_admin/application/auth/auth_bloc.dart';
import 'package:collaction_admin/domain/auth/value_validators.dart';
import 'package:collaction_admin/presentation/layout/responsiveness.dart';
import 'package:collaction_admin/presentation/shared/buttons/buttons.dart';
import 'package:collaction_admin/presentation/shared/form/input_field.dart';
import 'package:collaction_admin/presentation/shared/notifications/error.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:collaction_admin/presentation/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CreateCredentialsPage extends StatefulWidget {
  const CreateCredentialsPage({Key? key}) : super(key: key);

  @override
  State<CreateCredentialsPage> createState() => _CreateCredentialsPageState();
}

class _CreateCredentialsPageState extends State<CreateCredentialsPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  bool emailValidationError = true;
  bool passwordValidationError = true;
  bool confirmPasswordValidationError = false;
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
          preAuthenticated: (value) {
            value.user!.email;
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
                                        style: CollactionTextStyles.titleStyle)),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 8, right: 8),
                                  alignment: Alignment.center,
                                  child: const SelectableText(
                                      textAlign: TextAlign.center,
                                      'Please, enter your credentials to enter the CMS admin app.',
                                      style: CollactionTextStyles.captionStyle),
                                ),
                                const SizedBox(height: 10),
                                authError ? 
                                ErrorNotification(errorMessage: authErrorMessage,) : const SizedBox.shrink(),
                                const SizedBox(height: 15),
                                CollActionInputField(
                                  initialValue: _getInitialEmail(state),
                                  readonly: true,
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
                                    return validatePassword(value);
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                CollActionInputField(
                                  labelText: "Confirm Password",
                                  password: true,
                                  controller: confirmPasswordController,
                                  focusNode: confirmPasswordFocusNode,
                                  buttonTriggered: buttonTriggered,
                                  callback: (value) {
                                    setState(() {
                                      confirmPasswordValidationError = value;
                                    });
                                  },
                                  validationCallback: (value) {
                                    return validateConfirmPassword(value, passwordController.value.text);
                                  },
                                ),
                                const SizedBox(height: 30),
                                CollActionButton(
                                  text: "Sign in",
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

                                    if(confirmPasswordValidationError) return confirmPasswordFocusNode.requestFocus();
                                    
                                  }
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

  String _getInitialEmail(AuthState state) {

    late String initialEmail;

    state.mapOrNull(
      preAuthenticated: (value) {
        initialEmail = value.user!.email!;
      },
    );

    return initialEmail;
  }

  bool _isItLoading(AuthState state) {

    bool isItLoading = false;

    state.mapOrNull(
      verifyingUser: ((value) {
        isItLoading = true;
      })
    );

    return isItLoading;
  }
}