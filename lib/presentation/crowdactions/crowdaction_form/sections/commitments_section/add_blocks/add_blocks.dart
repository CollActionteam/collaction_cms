import 'package:collaction_cms/application/crowdaction/crowdaction_creation/commitments/commitments_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/add_blocks/add_blocks_select.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/add_blocks/blocks_radio_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlocks extends StatefulWidget {
  const AddBlocks({Key? key}) : super(key: key);

  @override
  State<AddBlocks> createState() => _AddBlocksState();
}

class _AddBlocksState extends State<AddBlocks> {
  bool _isLoading = true;
  Commitment? _selectedCommitment;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommitmentsBloc, CommitmentsState>(
      listener: (context, state) {
        state.map(
          commitmentsSet: (value) {
            _isLoading = false;
            if (_selectedCommitment == null && value.commitments.isNotEmpty) {
              _selectedCommitment = value.commitments[0];
            }

            if (_selectedCommitment != null && value.commitments.isNotEmpty) {
              _selectedCommitment = value.commitments.firstWhere(
                  (element) => element.id == _selectedCommitment!.id);
            }
          },
          initial: (value) {
            _isLoading = true;
          },
        );
      },
      builder: (context, state) {
        print(_isLoading == false
            ? "COMMITMENTS LENGTH: ${state.commitments.length}"
            : "loading");
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFDADADA),
              ),
            ),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 20,
              spacing: 90,
              children: [
                AddBlocksSelect(
                  isLoading: _isLoading,
                  commitments: state.commitments,
                  callback: (Commitment value) {
                    _selectedCommitment = value;
                    setState(() {});
                  },
                ),
                BlocksRadioTable(
                    selectedCommitment: _selectedCommitment ??
                        (state.commitments.isNotEmpty
                            ? state.commitments.first
                            : null),
                    // commitmentsToSelect: _selectedCommitment == null
                    //     ? []
                    //     : state.commitments
                    //         .where((element) =>
                    //             element.label != _selectedCommitment!.label)
                    //         .toList(),
                    commitments: _isLoading == true ? [] : state.commitments),
              ],
            ),
          ),
        );
      },
    );
  }

  // List<Commitment> _commitmentsToSelectLogic(CommitmentsState state) {
  //   if (_isLoading == true) {
  //     return [];
  //   }
  //   return state.commitments
  //       .where((element) => element.label != _selectedCommitment!.label)
  //       .toList();
  // }
}
