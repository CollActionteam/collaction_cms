import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class CollActionButton extends StatelessWidget {
  const CollActionButton({
    Key? key,
    this.width = double.infinity,
    this.loading = false,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final double width;
  final VoidCallback onPressed;
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
            ),
          ),
        ),
        onPressed: onPressed,
        child: !loading
            ? Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w700),
              )
            : const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white),
              ),
      ),
    );
  }
}

class CollActionButtonRectangle extends StatelessWidget {
  const CollActionButtonRectangle.wrapped({
    Key? key,
    required this.text,
    required this.onPressed,
    this.iconData,
    this.width,
    this.height = 32,
    this.padding = 12,
    this.inverted = false,
  }) : super(key: key);

  final String text;
  final IconData? iconData;
  final Color _backgroundColor = kAccentColor;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final double padding;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            inverted ? Colors.white : _backgroundColor,
          ),
          foregroundColor: MaterialStateProperty.all(
            inverted ? _backgroundColor : Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: const BorderSide(color: kAccentColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null) ...[
                Icon(iconData),
                const SizedBox(width: 15)
              ],
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
