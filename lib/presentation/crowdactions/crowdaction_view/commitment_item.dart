import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class CommitmentItem extends StatelessWidget {
  final IconData? iconData;
  final String label;
  final String description;
  final List<String?> tags;
  final int points;

  const CommitmentItem({
    super.key,
    this.iconData,
    required this.label,
    required this.description,
    required this.tags,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0XFFE7E7E7))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, left: 15),
            alignment: Alignment.topCenter,
            child: Icon(
              iconData,
              color: kAccentColor,
            ),
          ),
          const SizedBox(width: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF585858),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                SelectableText(
                  description,
                  style: CollactionTextStyles.body,
                ),
                const SizedBox(height: 5),
                SelectableText.rich(
                  TextSpan(
                    text: "Tags: ",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF585858),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: '[ ${tags.join(', ')} ]',
                        style: CollactionTextStyles.body,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SelectableText(
                  "Points: $points",
                  style: CollactionTextStyles.body,
                ),
                const SizedBox(height: 10)
              ],
            ),
          )
        ],
      ),
    );
  }
}
