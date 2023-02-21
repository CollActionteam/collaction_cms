import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/core/icons/icons_map.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_view/commitment_item.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class CommitmentsList extends StatelessWidget {
  CommitmentsList({
    super.key,
    required this.commitments,
  });

  final List<Commitment> commitments;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: commitments.isNotEmpty
            ? ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: commitments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CommitmentItem(
                      iconData: mapIcon(commitments[index].iconId),
                      label: commitments[index].label,
                      description: commitments[index].description!,
                      tags: commitments[index].tags,
                      points: commitments[index].points,
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  "Commitments not found",
                  style: CollactionTextStyles.body,
                ),
              ));
  }
}
