import 'package:collaction_cms/presentation/core/icons/icons_map.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_item_form.dart';
import 'package:collaction_cms/presentation/shared/items/commitment_item.dart';
import 'package:flutter/material.dart';

class AssignedCommitmentsList extends StatelessWidget {
  final bool buttonTriggered;
  AssignedCommitmentsList({
    Key? key,
    this.buttonTriggered = false,
  }) : super(key: key);

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
              buttonTriggered: buttonTriggered,
              iconData: mapIcon("no-beef"),
              label: "No beef for one week",
              commitmentItemType: CommitmentItemType.statusChecker,
            ),
          );
        });
  }
}
