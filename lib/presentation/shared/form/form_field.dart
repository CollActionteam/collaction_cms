import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class CollActionFormField extends StatelessWidget {
  final Widget child;
  final String? label;
  final double width;

  const CollActionFormField({
    super.key,
    required this.child,
    this.label,
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
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
