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
  final Function? stateModifier;
  final SmallOutlinedButtonType smallOutlinedButtonType;
  final VoidCallback? buttonCallback;
  final Commitment? commitmentInitialValue;

  @override
  State<CommitmentItemForm> createState() => _CommitmentItemFormState();
}

class _CommitmentItemFormState extends State<CommitmentItemForm> {
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
            widget.controller.validationOutputTitle = validationOutput;
            widget.stateModifier?.call();
          },
        ),
        CollActionTagsField(
            buttonTriggered: widget.buttonTriggered,
            backgroundColor: widget.backgroundColor,
            initialTagsList: const ["Hola"],
            validationCallback: validateEmptyField,
            callback: (ValidationOutput validationOutput) {
              widget.controller.validationOutputTags = validationOutput;
            }),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CollactionTextFormField(
                buttonTriggered: widget.buttonTriggered,
                label: "Points",
                backgroundColor: widget.backgroundColor,
                validationCallback: shouldBeInt,
                callback: (ValidationOutput validationOutput) {
                  widget.controller.validationOutputPoints = validationOutput;
                  widget.stateModifier?.call();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: CollActionIconField(
              buttonTriggered: widget.buttonTriggered,
              validationCallback: validateEmptyField,
              label: "Icons",
              callback: (ValidationOutput validationOutput) {
                widget.controller.validationOutputIcon = validationOutput;
                widget.stateModifier?.call();
              },
            ))
          ],
        ),
        CollactionTextFormField(
          backgroundColor: widget.backgroundColor,
          label: "Description",
          multiLine: true,
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
