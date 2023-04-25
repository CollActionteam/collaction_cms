part of 'constants.dart';

class CollActionBorderStyles {
  //Border of input fields to avoid contrast problems
  static BorderSide inputBorderSide = BorderSide(color: Colors.grey[200]!);

  static BorderSide formFieldBorderSide =
      const BorderSide(color: Color(0x80707070));

  static OutlineInputBorder formFieldBorderOutline = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: formFieldBorderSide);
}
