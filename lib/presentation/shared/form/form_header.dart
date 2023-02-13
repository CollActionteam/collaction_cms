import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormHeader extends StatelessWidget {
  final String title;

  const FormHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F2F2),
        borderRadius: BorderRadius.circular(5),
      ),
      constraints: const BoxConstraints.tightFor(height: 47),
      child: Row(
        children: [
          const SizedBox(width: 22),
          SvgPicture.asset(
            "assets/icons/info.svg",
            width: 20,
            color: const Color(0xFF2EB494),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              fontFamily: "Rubik",
              color: Color(0xFF707070),
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}
