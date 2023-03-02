import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/assigned_commitments.dart';
import 'package:collaction_cms/presentation/shared/composition/text_composition.dart';
import 'package:collaction_cms/presentation/shared/form/form_header.dart';
import 'package:flutter/material.dart';

class CrowdActionCommitmentsForm extends StatelessWidget {
  const CrowdActionCommitmentsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const FormHeader(title: "Commitments"),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Wrap(
              children: [
                AssignedCommitments(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
