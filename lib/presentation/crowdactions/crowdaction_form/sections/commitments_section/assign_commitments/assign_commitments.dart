import 'package:collaction_cms/application/crowdaction/crowdaction_creation/commitments/commitments_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_form_controller.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_item_form.dart';
import 'package:collaction_cms/presentation/shared/buttons/button_outlined.dart';
import 'package:collaction_cms/presentation/shared/buttons/combo_buttons.dart';
import 'package:collaction_cms/presentation/shared/composition/text_composition.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignCommitments extends StatefulWidget {
  final double? width;
  const AssignCommitments({
    Key? key,
    this.width,
  }) : super(key: key);

  @override
  State<AssignCommitments> createState() => _AssignCommitmentsState();
}

class _AssignCommitmentsState extends State<AssignCommitments> {
  bool onOrOff = false;
  bool _buttonTriggered = false;

  final CommitmentFormController _commitmentFormController =
      CommitmentFormController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width! - 20,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool shrink = constraints.maxWidth < 405;
          double fullWidth = shrink ? constraints.maxWidth : 405;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: fullWidth),
                child: TextComposition(
                  label: "Assign Commitments",
                  content:
                      """You can create commitments from scratch or you can choose any commitment from the templates registry.""",
                  textCompositionSize: TextCompositionSize.long,
                ),
              ),
              const SizedBox(height: 15),
              ComboButtonsOnOff(
                fontSize: 14,
                width: (fullWidth - 14) / 2,
                onOrOffCallback: (onOrOffValue) {
                  setState(
                    () {
                      onOrOff = onOrOffValue;
                    },
                  );
                },
              ),
              const SizedBox(height: 14),
              Container(
                width: fullWidth,
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
                          buttonTriggered: _buttonTriggered,
                          controller: _commitmentFormController,
                          backgroundColor: Colors.white,
                          smallOutlinedButtonType: SmallOutlinedButtonType.add,
                          buttonCallback: () => {
                            setState(() {
                              _buttonTriggered = true;
                            }),
                            if (_commitmentFormController.isReadyForBloc() &&
                                _preventLabelDuplication(
                                    _commitmentFormController
                                        .commitmentFactory(),
                                    context))
                              {
                                BlocProvider.of<CommitmentsBloc>(context).add(
                                  CommitmentsEvent.addCommitment(
                                    _commitmentFormController
                                        .commitmentFactory(),
                                  ),
                                )
                              }
                          },
                        ),
                      ),
              )
            ],
          );
        },
      ),
    );
  }

  bool _preventLabelDuplication(Commitment commitment, BuildContext context) {
    var labelList = BlocProvider.of<CommitmentsBloc>(context)
        .state
        .commitments
        .map((e) => e.label)
        .toList();

    if (labelList.contains(commitment.label)) {
      return false;
    } else {
      return true;
    }
  }
}
