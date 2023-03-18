import 'package:flutter/material.dart';

import '../../core/enums/enums.dart';
import '../../theme/constants.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    Key? key,
    required this.rectSide,
    required this.controller,
    this.searchBy,
    this.callback,
  }) : super(key: key);

  final RectSide rectSide;
  final TextEditingController controller;
  final String? searchBy;
  final VoidCallback? callback;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showIconLeft(widget.rectSide),
        Container(
          width: 380,
          height: 34,
          decoration: BoxDecoration(border: _border(widget.rectSide)),
          child: TextFormField(
            controller: widget.controller,
            style: CollactionTextStyles.body14,
            cursorColor: kAccentColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "Search by ${widget.searchBy}...",
              labelStyle: CollactionTextStyles.body14,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.only(bottom: 20, left: 10),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        showIconRight(widget.rectSide)
      ],
    );
  }

  Border _border(RectSide rectSide) {
    if (rectSide == RectSide.left) {
      return Border(
        top: CollActionBorderStyles.inputBorderSide,
        bottom: CollActionBorderStyles.inputBorderSide,
        left: CollActionBorderStyles.inputBorderSide,
      );
    } else {
      return Border(
        top: CollActionBorderStyles.inputBorderSide,
        bottom: CollActionBorderStyles.inputBorderSide,
        right: CollActionBorderStyles.inputBorderSide,
      );
    }
  }

  Widget showIconRight(RectSide rectSide) {
    if (rectSide == RectSide.left) {
      return SearchIcon(
        rectSide: rectSide,
        callback: widget.callback ?? () {},
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget showIconLeft(RectSide rectSide) {
    if (rectSide == RectSide.right) {
      return SearchIcon(
        rectSide: rectSide,
        callback: widget.callback ?? () {},
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class SearchIcon extends StatelessWidget {
  const SearchIcon({Key? key, this.rectSide, required this.callback})
      : super(key: key);

  final RectSide? rectSide;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: _borderRadius(rectSide),
        hoverColor: kAccentHoverColor,
        onTap: () => callback(),
        child: Ink(
          width: rectSide != null ? 39 : 36,
          height: 34,
          decoration: BoxDecoration(
              color: kAccentColor, borderRadius: _borderRadius(rectSide)),
          child: const Icon(
            Icons.search_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  BorderRadius _borderRadius(RectSide? rectSide) {
    if (rectSide == null) {
      return BorderRadius.circular(8);
    } else {
      if (rectSide == RectSide.left) {
        return const BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        );
      } else {
        return const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topLeft: Radius.circular(20),
        );
      }
    }
  }
}
