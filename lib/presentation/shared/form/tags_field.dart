import 'package:collaction_cms/presentation/shared/extra/tags_pills.dart';
import 'package:collaction_cms/presentation/shared/form/text_form_field.dart';
import 'package:flutter/material.dart';

class CollActionTagsField extends StatefulWidget {
  CollActionTagsField({
    super.key,
    required this.tagsList,
    required this.suffixCallback,
    required this.tagsCallback,
    this.backgroundColor = Colors.transparent,
  });

  final List<String> tagsList;
  final Function suffixCallback;
  final Function tagsCallback;
  final Color backgroundColor;

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
          backgroundColor: widget.backgroundColor,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Wrap(
            runSpacing: 7.5,
            direction: Axis.horizontal,
            children: [
              for (var tag in widget.tagsList)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TagPill(
                    backgroundColor: widget.backgroundColor,
                    value: tag,
                    callback: widget.tagsCallback,
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
