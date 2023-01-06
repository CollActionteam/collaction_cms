import 'package:collaction_cms/application/auth/auth_bloc.dart';
import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/shared/notifications/error.dart';
import 'package:collaction_cms/presentation/shared/notifications/info.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:collaction_cms/presentation/shared/form/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';


class SuccessfulInviteMessage extends StatefulWidget {
  SuccessfulInviteMessage({
    Key? key
    }) : super(key: key);

  @override
  State<SuccessfulInviteMessage> createState() => _SuccessfulInviteMessageState();
}

class _SuccessfulInviteMessageState extends State<SuccessfulInviteMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 28),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 96,
              maxWidth: 96
            ),
            child: const RiveAnimation.asset(
              'animations/check6.riv',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25),
          child: const SelectableText(
            "Invitation sent successfully",
            style: CollactionTextStyles.title2Style,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: const SelectableText(
            "The guest admin will receive the verification link",
            style: CollactionTextStyles.captionStyleLight
          ),
        ),
        const SizedBox(height: 24),
        const InfoNotification(),
        const SizedBox(height: 48,)
      ],
    );
  }
}