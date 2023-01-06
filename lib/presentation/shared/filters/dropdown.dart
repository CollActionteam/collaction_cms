import 'package:collaction_cms/presentation/core/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';

class DropdownFilter extends StatefulWidget {
  const DropdownFilter(
      {Key? key,
      required this.items,
      this.rectSide,
      this.getValueCallback,
      this.label})
      : super(key: key);

  final List<String> items;
  final RectSide? rectSide;
  final Function? getValueCallback;
  final String? label;

  @override
  State<DropdownFilter> createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 129,
          alignment: Alignment.center,
          child: DropdownButtonFormField(
            elevation: 2,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            itemHeight: 50,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              contentPadding: const EdgeInsets.only(
                  left: 14, right: 7, top: 10, bottom: 10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: _borderRadius(widget.rectSide),
                  borderSide: CollActionBorderStyles.inputBorderSide),
              focusedBorder: OutlineInputBorder(
                  borderRadius: _borderRadius(widget.rectSide),
                  borderSide: CollActionBorderStyles.inputBorderSide),
            ),
            value: _dropdownValue ?? widget.items.first,
            icon: Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_drop_down_rounded,
                size: 26,
              ),
            ),
            items: widget.items.map<DropdownMenuItem>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: CollactionTextStyles.body14),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _dropdownValue = value;
                widget.getValueCallback != null
                    ? widget.getValueCallback!(value)
                    : null;
              });
            },
          ),
        ),
      ],
    );
  }

  BorderRadius _borderRadius(RectSide? dropdownFilterRectSide) {
    if (dropdownFilterRectSide == null) {
      return const BorderRadius.all(Radius.circular(8));
    } else {
      if (dropdownFilterRectSide == RectSide.left) {
        return const BorderRadius.only(
            topLeft: Radius.zero,
            bottomLeft: Radius.zero,
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8));
      } else {
        return const BorderRadius.only(
          topRight: Radius.zero,
          bottomRight: Radius.zero,
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        );
      }
    }
  }
}
