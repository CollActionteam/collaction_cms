import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final double? width;

  const FormHeader({
    super.key,
    required this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F2F2),
        borderRadius: BorderRadius.circular(5),
      ),
      constraints: const BoxConstraints.tightFor(height: 47),
      child: Row(
        children: [
          const SizedBox(width: 22),
          const Icon(Icons.info, size: 24, color: kAccentColor),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF707070),
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
