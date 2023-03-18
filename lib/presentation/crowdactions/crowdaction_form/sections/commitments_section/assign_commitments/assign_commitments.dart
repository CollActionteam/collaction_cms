import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/assigned_commitments_list.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_form_controller.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_item_form.dart';
import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/shared/buttons/combo_buttons.dart';
import 'package:collaction_cms/presentation/shared/composition/text_composition.dart';
import 'package:collaction_cms/presentation/shared/extra/list_counter.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class AssignCommitments extends StatefulWidget {
  const AssignCommitments({Key? key}) : super(key: key);

  @override
  State<AssignCommitments> createState() => _AssignCommitmentsState();
}

class _AssignCommitmentsState extends State<AssignCommitments> {
  bool onOrOff = false;
  CommitmentFormController _commitmentFormController =
      CommitmentFormController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComposition(
          label: "Assign Commitments",
          content:
              """You can create commitments from scratch or you can choose any commitment from the templates registry.""",
          textCompositionSize: TextCompositionSize.long,
        ),
        const SizedBox(height: 15),
        ComboButtonsOnOff(
          fontSize: 14,
          width: 195,
          onOrOffCallback: (onOrOffValue) {
            setState(() {
              onOrOff = onOrOffValue;
            });
          },
        ),
        const SizedBox(height: 14),
        Container(
            width: 405,
            height: 540,
            decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFDADADA),
                )),
            child: !onOrOff
                ? Container(
                    padding: const EdgeInsets.only(top: 50),
                    alignment: Alignment.topCenter,
                    child: const SelectableText(
                      "Not yet supported",
                      style: CollactionTextStyles.body,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: CommitmentItemForm(
                      controller: _commitmentFormController,
                      backgroundColor: Colors.white,
                    ),
                  ))
      ],
    );
  }
}
