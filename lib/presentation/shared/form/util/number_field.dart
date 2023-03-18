import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/constants.dart';

class NumberField extends StatefulWidget {
  final String? label;
  final Function(int) onChanged;
  final TextEditingController controller;

  const NumberField({
    super.key,
    required this.onChanged,
    required this.controller,
    this.label,
  });

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  // TODO: Use or remove
  // ignore: unused_field
  bool _edited = false;
  bool _editing = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_focusChangeHandler);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusChangeHandler);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      showCursor: true,
      cursorColor: kAccentColor,
      cursorHeight: 30,
      controller: widget.controller,
      style: const TextStyle(
        fontSize: 30,
        color: kBlackPrimary300,
      ),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        counterText: "",
        contentPadding: const EdgeInsets.fromLTRB(3, 26, 0, 0),
        helperStyle: const TextStyle(
          color: kBlackPrimary300,
          fontSize: 12,
        ),
        helperText: widget.label,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 2,
      onChanged: (value) => _edited = true,
      onEditingComplete: () {
        widget.onChanged(int.parse(widget.controller.value.text));
        _edited = false;
      },
    );
  }

  void _focusChangeHandler() {
    if (!_focusNode.hasFocus && _editing == true) {
      _editing = false;
      widget.onChanged(int.parse(widget.controller.text));
    } else {
      _editing = true;
    }
  }
}
