import 'package:flutter/material.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';

class CollActionButton extends StatelessWidget {
  const CollActionButton({
    Key? key,
    this.width = double.infinity,
    this.loading = false,
    required this.onPressed,
    required this.text
  }) : super(key: key);

  final double width;
  final Function onPressed;
  final bool loading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 52,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kAccentColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ))),
        onPressed: () => onPressed(),
        child: !loading ?  Text(
          text,
          style: TextStyle(fontFamily: "Rubik", fontWeight: FontWeight.w700),
        ) : const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, )
            ),
      ),
    );
  }
}
