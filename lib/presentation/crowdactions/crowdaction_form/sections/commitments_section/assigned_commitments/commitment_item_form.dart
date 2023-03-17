import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/form/icon_field.dart';
import 'package:collaction_cms/presentation/shared/form/tags_field.dart';
import 'package:collaction_cms/presentation/shared/form/text_form_field.dart';
import 'package:flutter/material.dart';

class CommitmentItemForm extends StatefulWidget {
  const CommitmentItemForm({
    super.key,
    this.labelValue,
    this.backgroundColor = Colors.transparent,
  });

  final String? labelValue;
  final Color backgroundColor;

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
          label: "Label",
          initialValue: widget.labelValue ?? '',
          backgroundColor: widget.backgroundColor,
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
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: CollActionIconField(
              validationCallback: validateEmptyField,
              label: "Icons",
              callback: (ValidationOutput validationOutput) {},
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
