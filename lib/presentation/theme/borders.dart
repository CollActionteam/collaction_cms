part of 'constants.dart';

class CollActionBorderStyles {
  //Border of input fields to avoid contrast problems
  static BorderSide inputBorderSide = BorderSide(color: Colors.grey[200]!);

  static OutlineInputBorder formFieldBorderSide = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: Color(0x80707070)),
  );
}
