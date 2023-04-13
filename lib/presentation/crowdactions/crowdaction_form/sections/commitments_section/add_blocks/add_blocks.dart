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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommitmentsBloc, CommitmentsState>(
      listener: (context, state) {
        state.map(
          commitmentsSet: (value) {
            _isLoading = false;
          },
          initial: (value) {
            _isLoading = true;
          },
        );
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            height: 270,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFDADADA),
              ),
            ),
            child: Wrap(
              children: [
                AddBlocksSelect(
                    isLoading: _isLoading, commitments: state.commitments),
                SizedBox(
                  width: 80,
                ),
                BlocksRadioTable()
              ],
            ),
          ),
        );
      },
    );
  }
}
