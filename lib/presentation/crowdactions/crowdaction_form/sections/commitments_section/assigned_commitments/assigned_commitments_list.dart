import 'package:flutter/material.dart';

import '../../../../../core/icons/icons_map.dart';
import '../../../../../shared/items/commitment_item.dart';
import 'commitment_item_form.dart';

class AssignedCommitmentsList extends StatelessWidget {
  AssignedCommitmentsList({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CommitmentItem(
            iconData: mapIcon("no-beef"),
            label: "No beef for one week",
            commitmentItemType: CommitmentItemType.statusChecker,
            expandableChildWidget: const CommitmentItemForm(
              labelValue: "No beef for one week",
            ),
          ),
        );
      },
    );
  }
}
