import 'package:flutter/material.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';

class CollActionInputField extends StatelessWidget {
  const CollActionInputField.text({
    Key? key,
    this.labelText = "Placeholder",
    this.width = double.infinity,
    this.obscureText = false,
    this.controller,
  })  : assert(obscureText == false),
        super(key: key);

  const CollActionInputField.password({
    Key? key,
    this.labelText = "Password",
    this.width = double.infinity,
    this.obscureText = true,
    this.controller,
  })  : assert(obscureText == true),
        super(key: key);

  final String labelText;
  final double width;
  final bool obscureText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: kAccentColor,
        style: obscureText
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
            labelText: labelText,
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
    );
  }
}
