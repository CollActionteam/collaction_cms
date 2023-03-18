import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../shared/buttons/buttons.dart';
import '../../shared/composition/crowdaction_title.dart';
import '../../shared/tags/status.dart';
import '../../theme/constants.dart';

class CrowdActionHeader extends StatelessWidget {
  const CrowdActionHeader(
      {Key? key,
      required this.title,
      required this.joinStatus,
      required this.status,
      required this.participationCount})
      : super(key: key);

  final String title;
  final JoinStatus joinStatus;
  final Status status;
  final int participationCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CrowdActionTitle(joinStatus: joinStatus, title: title),
              const Spacer(),
              CollActionButtonRectangle.wrapped(
                text: "Edit CrowdAction",
                onPressed: () => {},
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              StatusTag(status: status),
              const SizedBox(width: 10),
              Container(
                alignment: Alignment.topLeft,
                width: 200,
                child: Row(
                  children: [
                    const Icon(
                      Icons.people_alt,
                      color: Color(0xFF585858),
                    ),
                    const SizedBox(width: 8),
                    SelectableText(
                      "$participationCount participants",
                      style: CollactionTextStyles.compositionTextBody,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
