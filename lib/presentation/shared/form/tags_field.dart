import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/extra/tags_pills.dart';
import 'package:collaction_cms/presentation/shared/form/text_form_field.dart';
import 'package:flutter/material.dart';

class CollActionTagsField extends StatefulWidget {
  CollActionTagsField({
    super.key,
    required this.tagsList,
    required this.suffixCallback,
    required this.tagsCallback,
    this.validationCallback,
    this.backgroundColor = Colors.transparent,
    this.callback,
  });

  final List<String> tagsList;
  final Function suffixCallback;
  final Function tagsCallback;
  final Color backgroundColor;
  final Function? validationCallback;
  final Function? callback;

  @override
  State<CollActionTagsField> createState() => _CollActionTagsFieldState();
}

class _CollActionTagsFieldState extends State<CollActionTagsField> {
  final TextEditingController _textEditingController = TextEditingController();
  late ValidationOutput _validationOutput;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.validationCallback == null
        ? _validationOutput = ValidationOutput(error: false)
        : _validationOutput = widget.validationCallback!(widget.tagsList);

    widget.callback == null ? null : widget.callback!(_validationOutput);
  }

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
