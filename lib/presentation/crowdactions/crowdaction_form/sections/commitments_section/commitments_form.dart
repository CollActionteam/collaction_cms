import 'package:flutter/material.dart';

import '../../../../shared/form/form_header.dart';
import 'assigned_commitments/assigned_commitments.dart';

class CrowdActionCommitmentsForm extends StatelessWidget {
  const CrowdActionCommitmentsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const FormHeader(title: "Commitments"),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Wrap(
              children: const [
                AssignedCommitments(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
