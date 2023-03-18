import 'package:flutter/material.dart';

import '../../theme/constants.dart';

enum TextCompositionSize { small, long }

class TextComposition extends StatelessWidget {
  const TextComposition({
    Key? key,
    required this.label,
    required this.content,
    required this.textCompositionSize,
  })  : maxWidth = textCompositionSize == TextCompositionSize.small ? 180 : 422,
        super(key: key);

  final String label;
  final String content;
  final TextCompositionSize textCompositionSize;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            label,
            style: CollactionTextStyles.bodySemiBold,
          ),
          const SizedBox(height: 12),
          SelectableText(
            content,
            style: CollactionTextStyles.body,
          )
        ],
      ),
    );
  }
}
