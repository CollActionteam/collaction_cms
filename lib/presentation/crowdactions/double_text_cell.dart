import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class DoubleTextCell extends StatefulWidget {
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
  State<DoubleTextCell> createState() => _DoubleTextCellState();
}

class _DoubleTextCellState extends State<DoubleTextCell> {

  TextStyle textStyle = CollactionTextStyles.hyperLink;
  ValueKey<int> valueKey = ValueKey<int>(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isItHyperlink == true ? 
          MouseRegion(
            onEnter: ((event) {
              setState(() {
                textStyle = CollactionTextStyles.hyperLinkOnHover;
                valueKey = ValueKey<int>(2);
              });
              
            }),
            onExit: (event) {
              setState(() {
                textStyle = CollactionTextStyles.hyperLink;
                valueKey = ValueKey<int>(1);
              });
            },
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => widget.callback!(),
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  widget.highlightedText,
                  key: valueKey,
                  style: textStyle,
                ),
              ),
            ),
          ) : SelectableText(
            widget.highlightedText,
            style: CollactionTextStyles.bodyMedium14,
          ),
          const SizedBox(height: 4),
          SelectableText(
            widget.regularText,
            style: CollactionTextStyles.body14
          )
        ],
      ),
    );
  }
}