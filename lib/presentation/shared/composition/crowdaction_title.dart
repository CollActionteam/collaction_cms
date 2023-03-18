import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../theme/constants.dart';

class CrowdActionTitle extends StatelessWidget {
  const CrowdActionTitle(
      {Key? key, required this.joinStatus, required this.title})
      : super(key: key);

  final JoinStatus joinStatus;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            joinStatus.value.toUpperCase(),
            style: CollactionTextStyles.body14Accent,
          ),
          SelectableText(
            title,
            style: CollactionTextStyles.titleStyleCMSAccent,
          )
        ],
      ),
    );
  }
}
