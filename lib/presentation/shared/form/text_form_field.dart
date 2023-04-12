import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/form/form_field.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class CollactionTextFormField extends StatefulWidget {
  final String? label;
  final double width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function? callback;
  final Function? validationCallback;
  final bool readOnly;
  final String? initialValue;
  final bool multiLine;
  final bool buttonTriggered;
  final TextStyle? style;
  final Color backgroundColor;
  final VoidCallback? stateModifierCallback;

  const CollactionTextFormField({
    super.key,
    this.label,
    this.width = double.infinity,
    this.controller,
    this.focusNode,
    this.callback,
    this.validationCallback,
    this.readOnly = false,
    this.initialValue,
    this.multiLine = false,
    this.buttonTriggered = false,
    this.style,
    this.backgroundColor = Colors.transparent,
    this.stateModifierCallback,
  });

  @override
  State<CollactionTextFormField> createState() =>
      _CollactionTextFormFieldState();
}

class _CollactionTextFormFieldState extends State<CollactionTextFormField> {
  late ValidationOutput _validationOutput;

  @override
  void initState() {
    super.initState();
    widget.validationCallback == null
        ? _validationOutput =
            ValidationOutput(error: false, output: widget.initialValue)
        : _validationOutput =
            widget.validationCallback!(widget.initialValue ?? "");

    widget.callback?.call(_validationOutput);
  }

  @override
  Widget build(BuildContext context) {
    return CollActionFormField(
      readOnly: widget.readOnly,
      error: widget.buttonTriggered && _validationOutput.error
          ? _validationOutput.output
          : null,
      label: widget.label,
      width: widget.width,
      child: SizedBox(
        height: widget.multiLine ? 87 : 32,
        child: TextFormField(
          style: widget.style ?? CollactionTextStyles.body,
          initialValue: widget.initialValue,
          readOnly: widget.readOnly,
          controller: widget.initialValue == null ? widget.controller : null,
          focusNode: widget.focusNode,
          onChanged: (value) {
            widget.validationCallback == null
                ? _validationOutput =
                    ValidationOutput(error: false, output: value)
                : _validationOutput = widget.validationCallback!(value);
            setState(() {});
            widget.stateModifierCallback?.call();
            widget.callback == null
                ? null
                : widget.callback!(_validationOutput);
          },
          cursorColor: kAccentColor,
          maxLines: widget.multiLine ? null : 1,
          expands: widget.multiLine ? true : false,
          textAlignVertical: widget.multiLine
              ? TextAlignVertical.top
              : TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
              8,
              widget.multiLine ? 8 : 25,
              8,
              widget.multiLine ? 8 : 0,
            ),
            enabledBorder: CollActionBorderStyles.formFieldBorderOutline,
            border: CollActionBorderStyles.formFieldBorderOutline,
            focusedBorder: CollActionBorderStyles.formFieldBorderOutline,
            fillColor:
                widget.readOnly ? kBlackPrimary0 : widget.backgroundColor,
            filled: true,
          ),
          mouseCursor: widget.readOnly
              ? SystemMouseCursors.basic
              : SystemMouseCursors.text,
          onTap: () {
            if (widget.readOnly) {
              FocusScope.of(context).unfocus();
            }
          },
        ),
      ),
    );
  }
}
