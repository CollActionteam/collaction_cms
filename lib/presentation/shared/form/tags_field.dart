import 'package:flutter/material.dart';

import '../extra/tags_pills.dart';
import 'text_form_field.dart';

class CollActionTagsField extends StatefulWidget {
  final List<String> tagsList;
  final Function suffixCallback;
  final VoidCallback tagsCallback;

  const CollActionTagsField({
    super.key,
    required this.tagsList,
    required this.suffixCallback,
    required this.tagsCallback,
  });

  @override
  State<CollActionTagsField> createState() => _CollActionTagsFieldState();
}

class _CollActionTagsFieldState extends State<CollActionTagsField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CollactionTextFormField(
          controller: _textEditingController,
          label: "Tags",
          actionSuffix: true,
          suffixCallback: widget.suffixCallback,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Wrap(
            runSpacing: 7.5,
            direction: Axis.horizontal,
            children: widget.tagsList
                .map(
                  (tag) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TagPill(
                      value: tag,
                      callback: widget.tagsCallback,
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
