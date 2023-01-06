import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class DoubleTextCell extends StatelessWidget {
  DoubleTextCell({
    Key? key,
    required this.highlightedText,
    required this.regularText,
    this.isItHyperlink = false,
    this.callback

    }) : super(key: key);

    final String highlightedText;
    final String regularText;
    final bool isItHyperlink;
    final Function? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isItHyperlink == true ? 
          GestureDetector(
            onTap: () => callback!(),
            child: SelectableText(
              highlightedText,
              style: CollactionTextStyles.hyperLink,
            ),
          ) : SelectableText(
            highlightedText,
            style: CollactionTextStyles.bodyMedium14,
          ),
          const SizedBox(height: 4),
          SelectableText(
            regularText,
            style: CollactionTextStyles.body14
          )
        ],
      ),
    );
  }
}