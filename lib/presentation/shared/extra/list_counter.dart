import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter(
      {Key? key,
      required this.counter,
      this.width,
      this.height,
      this.textStyle})
      : super(key: key);
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final String counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? 25,
      height: height ?? 25,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE7E7E7))),
      child: Container(
        transform: Matrix4.translationValues(2.2, 0, 0),
        child: Center(
          child: SelectableText(
            counter,
            style: textStyle ??
                const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Rubik",
                    color: Color(0xFF575757)),
          ),
        ),
      ),
    );
  }
}
