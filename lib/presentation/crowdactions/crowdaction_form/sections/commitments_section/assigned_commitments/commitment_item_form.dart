import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_form_controller.dart';
import 'package:collaction_cms/presentation/shared/form/icon_field.dart';
import 'package:collaction_cms/presentation/shared/form/tags_field.dart';
import 'package:collaction_cms/presentation/shared/form/text_form_field.dart';
import 'package:flutter/material.dart';

class CommitmentItemForm extends StatefulWidget {
  const CommitmentItemForm({
    super.key,
    this.labelValue,
    required this.controller,
    this.backgroundColor = Colors.transparent,
    this.stateModifier,
    this.buttonTriggered = false,
  });

  final String? labelValue;
  final bool buttonTriggered;
  final Color backgroundColor;
  final CommitmentFormController controller;
  //This is going to update the status checker icon of the parent widget.
  final Function? stateModifier;

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
          initialValue: widget.labelValue ?? '',
          backgroundColor: widget.backgroundColor,
          validationCallback: validateEmptyField,
          callback: (ValidationOutput validationOutput) {
            widget.controller.validationOutputTitle = validationOutput;
            widget.stateModifier != null ? widget.stateModifier!() : null;
          },
        ),
        CollActionTagsField(
            backgroundColor: widget.backgroundColor,
            tagsList: const [
              "Example",
              "Example",
              "Example",
              "Example",
              "Example",
            ],
            suffixCallback: () => {},
            tagsCallback: () => {},
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
                validationCallback: validateEmptyField,
                callback: (ValidationOutput validationOutput) {
                  widget.controller.validationOutputPoints = validationOutput;
                  widget.stateModifier != null ? widget.stateModifier!() : null;
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
                widget.stateModifier != null ? widget.stateModifier!() : null;
              },
            ))
          ],
        ),
        CollactionTextFormField(
          backgroundColor: widget.backgroundColor,
          label: "Description",
          multiLine: true,
        )
      ],
    );
  }
}
