import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/add_blocks/add_blocks.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/assigned_commitments.dart';
import 'package:collaction_cms/presentation/shared/composition/text_composition.dart';
import 'package:collaction_cms/presentation/shared/form/form_header.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/assign_commitments.dart';
import 'package:flutter/material.dart';

class CrowdActionCommitmentsForm extends StatelessWidget {
  final bool buttonTriggered;
  final double? width;

  const CrowdActionCommitmentsForm({
    Key? key,
    this.buttonTriggered = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const FormHeader(title: "Commitments"),
          const SizedBox(height: 30),
          Wrap(
            spacing: 30,
            runSpacing: 20,
            children: [
              AssignedCommitments(
                buttonTriggered: buttonTriggered,
                width: width,
              ),
              AssignCommitments(
                width: width,
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const AddBlocks()
        ],
      ),
    );
  }
}
