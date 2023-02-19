import 'package:flutter/material.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';

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
          style: const TextStyle(fontFamily: "Rubik", fontWeight: FontWeight.w700),
        ) : const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, )
            ),
      ),
    );
  }
}


class CollActionButtonRectangle extends StatelessWidget {
  const CollActionButtonRectangle.wrapped({
    Key? key,
    required this.text,
    this.iconData,
    required this.onPressed,
    }) : 
      super(key: key);

    final String text;
    final IconData? iconData;
    final Color _backgroundColor = kAccentColor;
    final Function onPressed;


  @override
  Widget build(BuildContext context) {  
    return SizedBox(
      height: 32,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        ),
        onPressed: () => onPressed(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconData != null ?_iconWidget(iconData) : const SizedBox.shrink(),
               iconData != null ? const SizedBox(
                width: 15,
              ) : const SizedBox.shrink(),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: "Rubik", 
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                  ),
              ),
            ],
          ),
        ) 
      ),
    );
  }

  Widget _iconWidget(IconData? iconData) {
    if(iconData != null) {
      return Icon(
        iconData
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
