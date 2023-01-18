import 'package:collaction_cms/application/auth/auth_bloc.dart';
import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/layout/responsiveness.dart';
import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/shared/form/input_field.dart';
import 'package:collaction_cms/presentation/shared/notifications/error.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
