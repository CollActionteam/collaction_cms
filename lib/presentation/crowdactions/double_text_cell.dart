import 'package:flutter/material.dart';

import '../theme/constants.dart';

class DoubleTextCell extends StatefulWidget {
  const DoubleTextCell({
    Key? key,
    required this.highlightedText,
    required this.regularText,
    this.isItHyperlink = false,
    this.callback,
  }) : super(key: key);

  final String highlightedText;
  final String regularText;
  final bool isItHyperlink;
  final VoidCallback? callback;

  @override
  State<DoubleTextCell> createState() => _DoubleTextCellState();
}

class _DoubleTextCellState extends State<DoubleTextCell> {
  TextStyle textStyle = CollactionTextStyles.hyperLink;
  ValueKey<int> valueKey = const ValueKey<int>(1);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isItHyperlink == true
            ? MouseRegion(
                onEnter: ((event) {
                  setState(() {
                    textStyle = CollactionTextStyles.hyperLinkOnHover;
                    valueKey = const ValueKey<int>(2);
                  });
                }),
                onExit: (event) {
                  setState(() {
                    textStyle = CollactionTextStyles.hyperLink;
                    valueKey = const ValueKey<int>(1);
                  });
                },
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.callback,
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
              )
            : SelectableText(
                widget.highlightedText,
                style: CollactionTextStyles.bodyMedium14,
              ),
        const SizedBox(height: 4),
        SelectableText(widget.regularText, style: CollactionTextStyles.body14)
      ],
    );
  }
}
