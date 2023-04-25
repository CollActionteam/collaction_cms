import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/extra/tags_pills.dart';
import 'package:collaction_cms/presentation/shared/form/form_field.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class CollActionTagsField extends StatefulWidget {
  CollActionTagsField({
    super.key,
    this.initialTagsList = const <String>[],
    this.buttonTriggered = false,
    this.validationCallback,
    this.backgroundColor = Colors.transparent,
    this.callback,
    this.stateModifierCallback,
  });

  final List<String> initialTagsList;
  final Color backgroundColor;
  final Function? validationCallback;
  final Function? callback;
  final bool buttonTriggered;
  final VoidCallback? stateModifierCallback;

  @override
  State<CollActionTagsField> createState() => _CollActionTagsFieldState();
}

class _CollActionTagsFieldState extends State<CollActionTagsField> {
  final TextEditingController _textEditingController = TextEditingController();
  late ValidationOutput _validationOutput;
  final ValueNotifier<List<String>> _tagsNotifier = ValueNotifier(<String>[]);

  @override
  void initState() {
    // TODO: implement initState

    widget.validationCallback == null
        ? _validationOutput = ValidationOutput(error: false)
        : _validationOutput =
            widget.validationCallback!(widget.initialTagsList);

    _tagsNotifier.value = widget.initialTagsList;
    _tagsNotifier.addListener(() {
      widget.validationCallback == null
          ? _validationOutput = ValidationOutput(error: false)
          : _validationOutput = widget.validationCallback!(_tagsNotifier.value);

      widget.callback?.call(_validationOutput);
      widget.stateModifierCallback?.call();
    });

    widget.callback?.call(_validationOutput);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CollActionFormField(
          error: widget.buttonTriggered && _validationOutput.error
              ? _validationOutput.output
              : null,
          label: "Tags",
          child: SizedBox(
            height: 32,
            child: TextFormField(
              controller: _textEditingController,
              style: CollactionTextStyles.body,
              cursorColor: kAccentColor,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
                  enabledBorder: CollActionBorderStyles.formFieldBorderOutline,
                  border: CollActionBorderStyles.formFieldBorderOutline,
                  focusedBorder: CollActionBorderStyles.formFieldBorderOutline,
                  fillColor: widget.backgroundColor,
                  filled: true,
                  suffixIcon: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        if (!_isIncluded(_tagsNotifier.value,
                                _textEditingController.text) &&
                            _textEditingController.text.isNotEmpty) {
                          setState(() {
                            _tagsNotifier.value = [
                              ..._tagsNotifier.value,
                              _textEditingController.text
                            ];
                            _textEditingController.text = "";
                          });
                        }
                      },
                      child: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.grey,
                      ),
                    ),
                  )),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Wrap(
            runSpacing: 7.5,
            direction: Axis.horizontal,
            children: [
              for (var tag in _tagsNotifier.value)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TagPill(
                    backgroundColor: widget.backgroundColor,
                    value: tag,
                    callback: () {
                      setState(() {
                        _tagsNotifier.value = _tagsNotifier.value
                            .where((element) => element != tag)
                            .toList();
                      });
                    },
                  ),
                )
            ],
          ),
        )
      ],
    );
  }

  bool _isIncluded(List<String> tags, String newTag) {
    bool isIncluded = false;
    for (var tag in tags) {
      if (tag.toLowerCase() == newTag.toLowerCase()) {
        isIncluded = true;
      }
    }
    return isIncluded;
  }
}
