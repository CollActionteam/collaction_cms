import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:flutter/material.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';

class CollActionInputField extends StatefulWidget {
  CollActionInputField(
      {Key? key,
      this.password = false,
      this.width = double.infinity,
      String? labelText,
      this.controller,
      this.focusNode,
      this.buttonTriggered = false,
      this.callback,
      this.validationCallback,
      this.readonly = false,
      this.initialValue})
      : labelText = labelText ?? (password ? "Password" : "Email"),
        super(key: key);

  final String? labelText;
  final double width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  bool? buttonTriggered;
  Function? callback;
  Function? validationCallback;
  final bool password;
  final bool readonly;
  final String? initialValue;

  @override
  State<CollActionInputField> createState() => _CollActionInputFieldState();
}

class _CollActionInputFieldState extends State<CollActionInputField> {
  late ValidationOutput _validationOutput;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.validationCallback == null
        ? _validationOutput = ValidationOutput(error: false)
        : _validationOutput =
            widget.validationCallback!(widget.initialValue ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Stack(
        children: [
          TextFormField(
            initialValue: widget.initialValue,
            readOnly: widget.readonly,
            obscureText: widget.password,
            controller: widget.initialValue == null ? widget.controller : null,
            focusNode: widget.focusNode,
            onChanged: (value) {
              widget.validationCallback == null
                  ? _validationOutput = ValidationOutput(error: false)
                  : _validationOutput = widget.validationCallback!(value);
              setState(() {});
              widget.callback == null
                  ? null
                  : widget.callback!(_validationOutput.error);
            },
            cursorColor: kAccentColor,
            style: widget.password
                ? const TextStyle(
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w300,
                    color: kBlackPrimary300,
                  )
                : const TextStyle(
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w300,
                    color: kBlackPrimary300,
                    fontSize: 15,
                  ),
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: widget.labelText,
                labelStyle: const TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: kPlaceholderTextColor),
                filled: true,
                fillColor: kFillInputTextColor,
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.transparent)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.transparent))),
          ),
          _validationOutput.error && widget.buttonTriggered!
              ? Container(
                  transform: Matrix4.translationValues(0, 50, 0),
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.only(right: 2, bottom: 2),
                      //   child: const Icon(
                      //     Icons.warning_rounded,
                      //     size: 18,
                      //     color: Colors.red,
                      //   )
                      // ),
                      Text("${_validationOutput.output}",
                          style: const TextStyle(
                              fontFamily: "Rubik",
                              color: Colors.red,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
