import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class CollActionFormField extends StatelessWidget {
  final Widget child;
  final String? label;
  final String? error;
  final double width;

  const CollActionFormField({
    super.key,
    required this.child,
    this.label,
    this.error,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: CollactionTextStyles.bodyMedium14,
          ),
          const SizedBox(height: 4),
          child,
          if (error == null) ...[
            const SizedBox(height: 15),
          ] else ...[
            Text(
              error!,
              style: const TextStyle(
                fontFamily: "Rubik",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: kRedColor,
              ),
            ),
            const SizedBox(height: 1),
          ],
        ],
      ),
    );
  }
}
