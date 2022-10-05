import 'package:flutter/material.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';

class CollActionButton extends StatelessWidget {
  const CollActionButton({
    Key? key,
    this.width = double.infinity,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kAccentColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ))),
        onPressed: onPressed(),
        child: const Text(
          "Sign In",
          style: TextStyle(fontFamily: "Rubik", fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
