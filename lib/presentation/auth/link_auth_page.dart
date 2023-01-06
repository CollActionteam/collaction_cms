import 'package:collaction_cms/application/auth/auth_bloc.dart';
import 'package:collaction_cms/application/navigation/navigation_bloc.dart';
import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/shared/notifications/error.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:collaction_cms/presentation/shared/form/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LinkAuthPage extends StatefulWidget {
  LinkAuthPage({Key? key}) : super(key: key);

  @override
  State<LinkAuthPage> createState() => _LinkAuthPageState();
}

class _LinkAuthPageState extends State<LinkAuthPage> {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  bool emailValidationError = true;
  bool buttonTriggered = false;

  bool authError = false;
  late String authErrorMessage;
  ValueNotifier<String> urlValueNotifier = ValueNotifier("");

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
          onVerification: (value) {
            urlValueNotifier.value = value.href!;
          },
        );
        return Scaffold(
            body: Center(
                child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 40, left: 5),
              child: Image.asset(
                'images/Vector.png',
                width: 200,
              ),
            ),
            Container(
              width: 374,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kLightBackgroundGreyColor,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 6,
                color: kLightBackgroundGreyColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 32),
                        child: const SelectableText("Confirm email",
                            style: CollactionTextStyles.titleStyle),
                      ),
                      Container(
                          padding:
                              const EdgeInsets.only(top: 16, left: 2, right: 2),
                          alignment: Alignment.center,
                          child: const SelectableText.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                  text: "Enter the ",
                                  style: CollactionTextStyles.captionStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "collaction@org ",
                                        style: CollactionTextStyles
                                            .captionStyleBold),
                                    TextSpan(
                                        text:
                                            "email to which the authentication link was sent.",
                                        style:
                                            CollactionTextStyles.captionStyle),
                                  ]))),
                      const SizedBox(height: 10),
                      authError
                          ? Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 5),
                              child: ErrorNotification(
                                  errorMessage: authErrorMessage))
                          : const SizedBox.shrink(),
                      const SizedBox(height: 15),
                      Container(
                        // padding: EdgeInsets.only(top: 25),
                        child: CollActionInputField(
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
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: CollActionButton(
                          loading: _isItLoading(state),
                          onPressed: () {
                            setState(() {
                              buttonTriggered = true;
                            });

                            if (!emailValidationError) {
                              BlocProvider.of<AuthBloc>(context).add(
                                  AuthEvent.verifyUser(
                                      emailController.value.text,
                                      urlValueNotifier.value));
                            }
                          },
                          text: "Confirm",
                        )
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 25, bottom: 50),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                              text: "Already an admin? ",
                              style: CollactionTextStyles.body,
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Go to Login",
                                    style: CollactionTextStyles.bodyBold)
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )));
      },
    );
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
