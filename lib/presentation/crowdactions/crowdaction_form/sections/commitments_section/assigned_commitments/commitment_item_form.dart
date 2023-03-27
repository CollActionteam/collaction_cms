import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_form_controller.dart';
import 'package:collaction_cms/presentation/shared/buttons/button_outlined.dart';
import 'package:collaction_cms/presentation/shared/form/icon_field.dart';
import 'package:collaction_cms/presentation/shared/form/tags_field.dart';
import 'package:collaction_cms/presentation/shared/form/text_form_field.dart';
import 'package:flutter/material.dart';

class CommitmentItemForm extends StatefulWidget {
  const CommitmentItemForm({
    super.key,
    required this.controller,
    this.backgroundColor = Colors.transparent,
    this.stateModifier,
    this.buttonTriggered = false,
    required this.smallOutlinedButtonType,
    required this.buttonCallback,
    this.commitmentInitialValue,
  });

  final bool buttonTriggered;
  final Color backgroundColor;
  final CommitmentFormController controller;
  //This is going to update the status checker icon of the parent widget.
  final VoidCallback? stateModifier;
  final SmallOutlinedButtonType smallOutlinedButtonType;
  final VoidCallback? buttonCallback;
  final Commitment? commitmentInitialValue;

  @override
  State<CommitmentItemForm> createState() => _CommitmentItemFormState();
}

class _CommitmentItemFormState extends State<CommitmentItemForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        CollactionTextFormField(
          buttonTriggered: widget.buttonTriggered,
          label: "Title",
          initialValue: widget.commitmentInitialValue?.label ?? '',
          backgroundColor: widget.backgroundColor,
          validationCallback: validateEmptyField,
          callback: (ValidationOutput validationOutput) {
            widget.controller.setValidationOutput("title", validationOutput);
          },
          stateModifierCallback: widget.stateModifier,
        ),
        CollActionTagsField(
          buttonTriggered: widget.buttonTriggered,
          backgroundColor: widget.backgroundColor,
          initialTagsList: widget.commitmentInitialValue?.tags ?? [],
          validationCallback: validateEmptyField,
          callback: (ValidationOutput validationOutput) {
            widget.controller.setValidationOutput("tags", validationOutput);
          },
          stateModifierCallback: widget.stateModifier,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CollactionTextFormField(
                initialValue:
                    widget.commitmentInitialValue?.points.toString() ?? '',
                buttonTriggered: widget.buttonTriggered,
                label: "Points",
                backgroundColor: widget.backgroundColor,
                validationCallback: shouldBeInt,
                callback: (ValidationOutput validationOutput) {
                  widget.controller
                      .setValidationOutput("points", validationOutput);
                },
                stateModifierCallback: widget.stateModifier,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: CollActionIconField(
              initialData: widget.commitmentInitialValue?.iconId,
              buttonTriggered: widget.buttonTriggered,
              validationCallback: validateEmptyField,
              label: "Icons",
              callback: (ValidationOutput validationOutput) {
                widget.controller.setValidationOutput("icon", validationOutput);
              },
            ))
          ],
        ),
        CollactionTextFormField(
          initialValue: widget.commitmentInitialValue?.description ?? '',
          backgroundColor: widget.backgroundColor,
          label: "Description",
          multiLine: true,
          callback: (ValidationOutput validationOutput) {
            widget.controller
                .setValidationOutput("description", validationOutput);
          },
          stateModifierCallback: widget.stateModifier,
        ),
        SmallOutlinedButton(
          width: 69,
          smallOutlinedButtonType: widget.smallOutlinedButtonType,
          callback: widget.buttonCallback,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
