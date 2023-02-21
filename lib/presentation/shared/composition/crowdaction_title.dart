import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class CrowdActionTitle extends StatelessWidget {
  const CrowdActionTitle({
    Key? key,
    required this.joinStatus,
    required this.title
    }) : super(key: key);

    final JoinStatus joinStatus;
    final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
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