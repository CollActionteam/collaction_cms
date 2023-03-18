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
  });

  final String? labelValue;
  final Color backgroundColor;
  final CommitmentFormController controller;

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
          label: "Title",
          initialValue: widget.labelValue ?? '',
          backgroundColor: widget.backgroundColor,
          validationCallback: validateEmptyField,
          callback: (ValidationOutput validationOutput) {
            widget.controller.validationOutputTitle = validationOutput;
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
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CollactionTextFormField(
                label: "Points",
                backgroundColor: widget.backgroundColor,
                validationCallback: validateEmptyField,
                callback: (ValidationOutput validationOutput) {
                  widget.controller.validationOutputPoints = validationOutput;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: CollActionIconField(
              validationCallback: validateEmptyField,
              label: "Icons",
              callback: (ValidationOutput validationOutput) {
                widget.controller.validationOutputIcon = validationOutput;
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
