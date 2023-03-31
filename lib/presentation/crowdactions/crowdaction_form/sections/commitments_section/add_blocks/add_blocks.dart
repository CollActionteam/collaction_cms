import 'package:flutter/material.dart';

class AddBlocks extends StatelessWidget {
  const AddBlocks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 270,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFDADADA),
          ),
        ),
      ),
    );
  }
}
