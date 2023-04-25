import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

enum SmallOutlinedButtonType { add, remove }

class SmallOutlinedButton extends StatelessWidget {
  const SmallOutlinedButton({
    super.key,
    required this.smallOutlinedButtonType,
    required this.callback,
    this.width,
  });

  final SmallOutlinedButtonType smallOutlinedButtonType;
  final Function? callback;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: width ??
          (smallOutlinedButtonType == SmallOutlinedButtonType.add ? 47 : 69),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
                smallOutlinedButtonType == SmallOutlinedButtonType.add
                    ? addOutlinedColor.withOpacity(0.1)
                    : removeOutlinedColor.withOpacity(0.1)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            splashFactory: InkSplash.splashFactory,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: smallOutlinedButtonType == SmallOutlinedButtonType.add
                      ? addOutlinedColor
                      : removeOutlinedColor,
                ),
              ),
            )),
        onPressed: () => callback?.call(),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            smallOutlinedButtonType == SmallOutlinedButtonType.add
                ? "Add"
                : "Remove",
            style: TextStyle(
              fontSize: 12,
              color: smallOutlinedButtonType == SmallOutlinedButtonType.add
                  ? addOutlinedColor
                  : removeOutlinedColor,
            ),
          ),
        ),
      ),
    );
  }
}
