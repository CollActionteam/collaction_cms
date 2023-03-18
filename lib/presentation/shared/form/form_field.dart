import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class CollActionFormField extends StatelessWidget {
  final Widget child;
  final String? label;
  final String? caption;
  final String? error;
  final double width;
  final bool readOnly;

  const CollActionFormField({
    super.key,
    required this.child,
    this.label,
    this.caption,
    this.error,
    this.width = double.infinity,
    this.readOnly = false,
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
          if (caption != null) ...[
            const SizedBox(height: 10),
            Text(caption!, style: CollactionTextStyles.body14),
            const SizedBox(height: 10),
          ] else ...[
            const SizedBox(height: 4),
          ],
          IgnorePointer(
            ignoring: readOnly,
            child: child,
          ),
          if (error == null) ...[
            const SizedBox(height: 15),
          ] else ...[
            Text(
              error!,
              style: const TextStyle(
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
