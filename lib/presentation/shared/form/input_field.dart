import 'dart:async';

import 'package:collaction_admin/domain/core/value_failures.dart';
import 'package:collaction_admin/presentation/shared/utils/map_domain_presentation/map_value_validators.dart';
import 'package:flutter/material.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:dartz/dartz.dart' as dartz;


class CollActionInputField extends StatefulWidget {
  CollActionInputField({
    Key? key,
    this.password = false,
    this.width = double.infinity,
    String? labelText,
    this.controller,
    this.focusNode,
    this.buttonTriggered = false,
    this.callback,
    this.validationCallback
  })  : 
  labelText = password ? "Password": "Email",
  super(key: key);
        

  final String labelText;
  final double width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  bool? buttonTriggered;
  Function? callback;
  Function? validationCallback;
  final bool password;

  @override
  State<CollActionInputField> createState() => _CollActionInputFieldState();
}

class _CollActionInputFieldState extends State<CollActionInputField> {

  late MapValidationOutput _mapValidationOutput;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mapValidationOutput = mapValidation(widget.validationCallback!(""));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Stack(
        children: [
          TextFormField(
            obscureText: widget.password,
            controller: widget.controller,
            focusNode: widget.focusNode,
            onChanged: (value) {
              _mapValidationOutput = mapValidation(widget.validationCallback!(value));
              setState(() {
              });
                widget.callback!(_mapValidationOutput.error);
            },
            cursorColor: kAccentColor,
            style: widget.password 
                  ? const TextStyle(
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w300,
                      color: kInputTextColor,
                    )
                  : const TextStyle(
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w300,
                      color: kInputTextColor,
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
          _mapValidationOutput.error && widget.buttonTriggered! ?
            Container(
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
                  Text(
                    "${_mapValidationOutput.output}",
                    style: const TextStyle(
                      fontFamily: "Rubik",
                      color: Colors.red,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400
                    )
                  )
                ],
              ),
            ) : const SizedBox.shrink()
        ],
      ),
    );
  }

    
}