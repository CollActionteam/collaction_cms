import 'package:collaction_cms/application/crowdaction/crowdaction_creation/commitments/commitments_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlocksRadioTable extends StatefulWidget {
  final List<Commitment> commitmentsToSelect;
  final Commitment? selectedCommitment;
  const BlocksRadioTable({
    Key? key,
    required this.commitmentsToSelect,
    required this.selectedCommitment,
  }) : super(key: key);

  @override
  State<BlocksRadioTable> createState() => _BlocksRadioTableState();
}

class _BlocksRadioTableState extends State<BlocksRadioTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 230,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFDADADA),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SelectableText(
                "LABEL",
                style: CollactionTextStyles.body,
              ),
              const Spacer(),
              SvgPicture.asset(
                width: 18,
                "assets/icons/disabled.svg",
                color: Colors.grey[600],
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.commitmentsToSelect.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    SelectableText(
                      widget.commitmentsToSelect[index].label,
                      style: CollactionTextStyles.bodyAccent,
                    ),
                    const Spacer(),
                    Transform(
                      transform: Matrix4.translationValues(6.5, 0, 0),
                      child: Checkbox(
                          splashRadius: 12,
                          shape: const CircleBorder(),
                          value: _isItBlocked(widget.selectedCommitment,
                              widget.commitmentsToSelect[index]),
                          onChanged: (value) {
                            _triggerBlocEvent(
                                context,
                                value!,
                                widget.selectedCommitment!,
                                widget.commitmentsToSelect[index]);
                          }),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  bool _isItBlocked(
      Commitment? selectedComitment, Commitment commitmentToSelect) {
    try {
      if (widget.selectedCommitment!.blocks.contains(commitmentToSelect.id)) {
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  void _triggerBlocEvent(BuildContext context, bool checkBoxValue,
      Commitment selectedCommitment, Commitment commitmentToSelect) {
    late Commitment commitmentEdited;
    if (checkBoxValue) {
      commitmentEdited = selectedCommitment.copyWith(
          blocks: [...selectedCommitment.blocks, commitmentToSelect.id]);
    } else {
      commitmentEdited = selectedCommitment.copyWith(blocks: [
        ...selectedCommitment.blocks
            .where((element) => element != commitmentToSelect.id)
      ]);
    }

    BlocProvider.of<CommitmentsBloc>(context)
        .add(CommitmentsEvent.editCommitment(commitmentEdited));
  }
}
