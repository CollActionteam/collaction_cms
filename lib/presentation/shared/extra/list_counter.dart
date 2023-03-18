import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key, required this.counter}) : super(key: key);

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE7E7E7)),
      ),
      transform: Matrix4.translationValues(2.2, 0, 0),
      child: SelectableText(
        "$counter",
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF575757),
        ),
      ),
    );
  }
}
