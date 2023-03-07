import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class TagPill extends StatelessWidget {
  const TagPill({
    super.key,
    required this.value,
    required this.callback,
  });

  final String value;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFF707070).withOpacity(0.5),
              )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => callback(),
                  child: const Icon(
                    Icons.close,
                    size: 14,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                value,
                style: CollactionTextStyles.captionStyleBold.copyWith(
                  color: const Color(0xFF585858),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
