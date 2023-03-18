import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../shared/extra/list_counter.dart';
import '../../theme/constants.dart';
import 'commitments_list.dart';

class CommitmentsPanel extends StatelessWidget {
  const CommitmentsPanel({
    super.key,
    required this.commitments,
  });

  final List<Commitment> commitments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 35),
        Row(
          children: [
            const SelectableText(
              "Commitments",
              style: CollactionTextStyles.subtitleStyleCMS,
            ),
            const SizedBox(width: 7),
            Counter(counter: commitments.length)
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFFE7E7E7))),
          height: 460,
          width: 470,
          child: CommitmentsList(commitments: commitments),
        )
      ],
    );
  }
}
