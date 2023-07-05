import 'package:flutter/material.dart';

import '../../../../../../../theme/constants.dart';

class PreviousNextbutton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonAction;
  const PreviousNextbutton(
      {super.key, required this.buttonText, required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      margin: const EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: kBlackPrimary200,
        ),
      ),
      child: TextButton(
          onPressed: buttonAction,
          child: Text(
            buttonText,
            style: CollactionTextStyles.captionStyleLight.copyWith(height: -1),
          )),
    );
  }
}
