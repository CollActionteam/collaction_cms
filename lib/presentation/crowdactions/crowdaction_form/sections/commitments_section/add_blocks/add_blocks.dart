import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/add_blocks/add_blocks_select.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/add_blocks/blocks_radio_table.dart';
import 'package:flutter/material.dart';

class AddBlocks extends StatelessWidget {
  const AddBlocks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        alignment: Alignment.topLeft,
        width: double.infinity,
        height: 270,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFDADADA),
          ),
        ),
        child: Wrap(
          children: const [
            Expanded(child: AddBlocksSelect()),
            SizedBox(
              width: 80,
            ),
            Expanded(child: BlocksRadioTable())
          ],
        ),
      ),
    );
  }
}
