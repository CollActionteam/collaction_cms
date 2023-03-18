import '../../theme/constants.dart';
import 'package:flutter/material.dart';

class SpecialNavigationItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function() onTap;

  const SpecialNavigationItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SpecialNavigationItem> createState() => _SpecialNavigationItemState();
}

class _SpecialNavigationItemState extends State<SpecialNavigationItem> {
  Color _backgroundColor = kAccentColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => _backgroundColor = kAccentHoverColor),
      onExit: (event) => setState(() => _backgroundColor = kAccentColor),
      child: GestureDetector(
        onTap: () => widget.onTap(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: _backgroundColor,
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: kPrimaryColor),
              const SizedBox(width: 15),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
