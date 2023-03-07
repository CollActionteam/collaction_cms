import 'package:collaction_cms/presentation/shared/form/tags_field.dart';
import 'package:collaction_cms/presentation/shared/form/text_form_field.dart';
import 'package:flutter/material.dart';

class CommitmentItemForm extends StatefulWidget {
  const CommitmentItemForm({
    super.key,
    this.labelValue,
  });

  final String? labelValue;

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
          initialValue: "${widget.labelValue}",
        ),
        CollActionTagsField(
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
      ],
    );
  }
}
