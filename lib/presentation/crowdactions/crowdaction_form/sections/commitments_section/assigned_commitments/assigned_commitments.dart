import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/assigned_commitments_list.dart';
import 'package:collaction_cms/presentation/shared/composition/text_composition.dart';
import 'package:collaction_cms/presentation/shared/extra/list_counter.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class AssignedCommitments extends StatelessWidget {
  final bool buttonTriggered;

  const AssignedCommitments({
    Key? key,
    this.buttonTriggered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComposition(
          label: "Assigned Commitments",
          content: """Add commitments in the right section "Assign Commitments".
These commitments are going to be assigned to the crowdAction. Click to expand to delete/edit.""",
          textCompositionSize: TextCompositionSize.long,
        ),
        const SizedBox(height: 15),
        Container(
          width: 405,
          height: 574,
          decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFDADADA),
              )),
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFDADADA),
                      ),
                    ),
                  ),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          SelectableText("Commitments Selected",
                              style: CollactionTextStyles.bodySemiBold),
                          SizedBox(width: 10),
                          Counter(counter: 5),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: AssignedCommitmentsList(
                      buttonTriggered: buttonTriggered,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
