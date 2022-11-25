import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class NavigationItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function() onTap;
  final bool isActive;

  const NavigationItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  late Color _backgroundColor =
      widget.isActive ? kNavItemActiveBackgroundColor : kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(
          () => _backgroundColor = kNavItemActiveBackgroundColor,
        ),
        onExit: (event) => setState(
          () => _backgroundColor =
              widget.isActive ? kNavItemActiveBackgroundColor : kPrimaryColor,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: _backgroundColor,
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.isActive
                    ? kNavItemActiveColor
                    : kNavItemInactiveColor,
              ),
              const SizedBox(width: 15),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16.0,
                  color: widget.isActive
                      ? kNavItemActiveColor
                      : kNavItemInactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}