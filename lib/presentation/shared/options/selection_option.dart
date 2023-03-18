import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class SelectionOption extends StatefulWidget {
  final IconData iconData;
  final String text;
  final Function callback;
  final bool isSelected;

  const SelectionOption({
    Key? key,
    required this.iconData,
    required this.text,
    required this.callback,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<SelectionOption> createState() => _SelectionOptionState();
}

class _SelectionOptionState extends State<SelectionOption> {
  bool onHover = false;
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kAccentColor,
      onTap: () {
        widget.callback();
        setState(() => isSelected = true);
      },
      onHover: (value) => setState(() => onHover = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: onHover || widget.isSelected
                ? const Color(0xFFEAEAEA)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE7E7E7))),
        child: Row(
          children: [
            Icon(
              widget.iconData,
              color: const Color(0xFF585858),
              size: 24,
            ),
            const SizedBox(width: 10),
            Text(
              widget.text,
              style: CollactionTextStyles.body,
            )
          ],
        ),
      ),
    );
  }
}
