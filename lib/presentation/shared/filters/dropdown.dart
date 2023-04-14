import 'package:collaction_cms/presentation/core/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';

class DropdownField extends StatefulWidget {
  DropdownField({
    Key? key,
    required this.items,
    this.rectSide,
    this.getValueCallback,
    this.label,
    this.backgroundColor = Colors.white,
    this.borderStyle,
    this.primaryColor = false,
    this.isLoading,
  }) : super(key: key) {
    borderStyle ??= CollActionBorderStyles.inputBorderSide;
  }

  final List<String> items;
  final RectSide? rectSide;
  final Function? getValueCallback;
  final String? label;
  final Color backgroundColor;
  BorderSide? borderStyle;
  final bool primaryColor;
  final bool? isLoading;

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 32,
          width: double.infinity,
          alignment: Alignment.center,
          child: DropdownButtonFormField(
            isExpanded: true,
            menuMaxHeight: 270,
            focusColor: Colors.transparent,
            dropdownColor: widget.backgroundColor,
            elevation: 2,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            itemHeight: 50,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.backgroundColor,
              focusColor: widget.backgroundColor,
              contentPadding:
                  const EdgeInsets.only(left: 8, right: 4, top: 8, bottom: 8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: _borderRadius(widget.rectSide),
                  borderSide: widget.borderStyle!),
              focusedBorder: OutlineInputBorder(
                  borderRadius: _borderRadius(widget.rectSide),
                  borderSide: widget.borderStyle!),
            ),
            value: widget.isLoading == false || widget.isLoading == null
                ? widget.items.contains(_dropdownValue)
                    ? _dropdownValue
                    : widget.items.first
                : null,
            icon: Container(
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.arrow_drop_down_rounded,
                size: 26,
              ),
            ),
            items: widget.items.map<DropdownMenuItem>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    value,
                    style: widget.primaryColor
                        ? CollactionTextStyles.bodyAccent
                            .copyWith(fontWeight: FontWeight.w400)
                        : CollactionTextStyles.body,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _dropdownValue = value;
                widget.getValueCallback?.call(value);
              });
            },
          ),
        ),
      ],
    );
  }

  BorderRadius _borderRadius(RectSide? dropdownFilterRectSide) {
    if (dropdownFilterRectSide == null) {
      return const BorderRadius.all(Radius.circular(5));
    } else {
      if (dropdownFilterRectSide == RectSide.left) {
        return const BorderRadius.only(
            topLeft: Radius.zero,
            bottomLeft: Radius.zero,
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5));
      } else {
        return const BorderRadius.only(
          topRight: Radius.zero,
          bottomRight: Radius.zero,
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        );
      }
    }
  }

  String? getInitialValue() {}
}
