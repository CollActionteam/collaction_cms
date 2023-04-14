import 'package:collaction_cms/application/crowdaction/crowdaction_creation/commitments/commitments_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/core/icons/icons_map.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_item_form.dart';
import 'package:collaction_cms/presentation/shared/items/commitment_item.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignedCommitmentsList extends StatefulWidget {
  final bool buttonTriggered;
  final List<Commitment> commitments;
  AssignedCommitmentsList({
    Key? key,
    this.buttonTriggered = false,
    required this.commitments,
  }) : super(key: key);

  @override
  State<AssignedCommitmentsList> createState() =>
      _AssignedCommitmentsListState();
}

class _AssignedCommitmentsListState extends State<AssignedCommitmentsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return widget.commitments.isNotEmpty
        ? ListView.builder(
            controller: _scrollController,
            itemCount: widget.commitments.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CommitmentItem(
                    commitment: widget.commitments[index],
                    buttonTriggered: widget.buttonTriggered,
                    commitmentItemType: CommitmentItemType.statusChecker,
                    buttonCallback: () {
                      BlocProvider.of<CommitmentsBloc>(context).add(
                          CommitmentsEvent.removeCommitment(
                              widget.commitments[index].id));
                    },
                    formOnChange: (Commitment commitment) {
                      BlocProvider.of<CommitmentsBloc>(context)
                          .add(CommitmentsEvent.editCommitment(commitment));
                    }),
              );
            })
        : Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 80),
            child: const SelectableText(
              "Commitments not found",
              style: CollactionTextStyles.body,
            ),
          );
  }
}
