import 'package:collaction_cms/application/auth/auth_bloc.dart';
import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/modals/invite_admin_success.dart';
import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/shared/notifications/error.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:collaction_cms/presentation/shared/form/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class InviteAdminModal extends StatefulWidget {
  InviteAdminModal({Key? key}) : super(key: key);

  @override
  State<InviteAdminModal> createState() => _InviteAdminModalState();
}

class _InviteAdminModalState extends State<InviteAdminModal> {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  bool emailValidationError = true;
  bool buttonTriggered = false;

  bool authError = false;
  late String authErrorMessage;
  bool invitationSuccess = false;

  final ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: "http://localhost:56289/verification", handleCodeInApp: true);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 6,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      backgroundColor: kLightBackgroundGreyColor,
      child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        state.mapOrNull(authError: (value) {
          authError = true;
          authErrorMessage = value.failure.error;
        }, inviteAdminDone: ((value) {
          setState(() {
            invitationSuccess = true;
          });
        }));
      }, builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: const BoxDecoration(
              color: kLightBackgroundGreyColor,
            ),
            width: 374,
            // height: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: invitationSuccess
                    ? SuccessfulInviteMessage()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 40),
                            alignment: Alignment.center,
                            child: const SelectableText("Invite an Admin",
                                style: CollactionTextStyles.titleStyle),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 16),
                              alignment: Alignment.center,
                              child: const SelectableText.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                      text:
                                          "When inviting an admin, they must have an existing account in the application, the email ",
                                      style: CollactionTextStyles.captionStyle,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "must ",
                                            style: CollactionTextStyles
                                                .captionStyleBold),
                                        TextSpan(
                                            text: "be a ",
                                            style: CollactionTextStyles
                                                .captionStyle),
                                        TextSpan(
                                            text: "@collaction.org ",
                                            style: CollactionTextStyles
                                                .captionStyleBold),
                                        TextSpan(
                                            text: "email. ",
                                            style: CollactionTextStyles
                                                .captionStyle),
                                      ]))),
                          const SizedBox(
                            height: 10,
                          ),
                          authError
                              ? ErrorNotification(
                                  errorMessage: authErrorMessage)
                              : const SizedBox.shrink(),
                          const SizedBox(height: 15),
                          Container(
                              padding: const EdgeInsets.only(),
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
                              )),
                          Container(
                            padding:
                                const EdgeInsets.only(top: 30, bottom: 40),
                            child: CollActionButton(
                              loading: _isItLoading(state),
                              text: "Send",
                              onPressed: () {
                                setState(() {
                                  buttonTriggered = true;
                                });

                                if (!emailValidationError) {
                                  BlocProvider.of<AuthBloc>(context).add(
                                      AuthEvent.sendSignInLinkToEmail(
                                          emailController.value.text,
                                          actionCodeSettings));
                                }

                                if (emailValidationError) return emailFocusNode.requestFocus();
                              },
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        );
      }),
    );
  }

  bool _isItLoading(AuthState state) {
    bool isItLoading = false;

    state.mapOrNull(invitingAdmin: ((value) {
      isItLoading = true;
    }));

    return isItLoading;
  }
}
