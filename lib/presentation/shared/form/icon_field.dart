import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/core/icons/icons_map.dart';
import 'package:collaction_cms/presentation/shared/form/form_field.dart';
import 'package:collaction_cms/presentation/shared/form/util/country_search.dart';
import 'package:collaction_cms/presentation/shared/form/util/field_popup.dart';
import 'package:collaction_cms/presentation/shared/form/util/icon_search.dart';
import 'package:collaction_cms/presentation/theme/button.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

class CollActionIconField extends StatefulWidget {
  final String? label;
  final String? icon;
  final double width;
  final Function? callback;
  final Function? validationCallback;
  final bool readOnly;
  final bool buttonTriggered;

  const CollActionIconField({
    super.key,
    this.label,
    this.icon,
    this.width = double.infinity,
    this.callback,
    this.validationCallback,
    this.readOnly = false,
    this.buttonTriggered = false,
  });

  @override
  State<CollActionIconField> createState() => _CollActionIconFieldState();
}

class _CollActionIconFieldState extends State<CollActionIconField> {
  late ValidationOutput _validationOutput;
  String? _selectedIcon;

  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    widget.validationCallback == null
        ? _validationOutput = ValidationOutput(error: false)
        : _validationOutput = widget.validationCallback!(widget.icon);
  }

  @override
  Widget build(BuildContext context) {
    return CollActionFormField(
      readOnly: widget.readOnly,
      error: widget.buttonTriggered && _validationOutput.error
          ? _validationOutput.output
          : null,
      label: widget.label,
      width: widget.width,
      child: SizedBox(
        height: 32,
        child: Stack(
          children: [
            TextButton(
              style: formFieldButtonStyle(
                  readOnly: widget.readOnly, backgroundColor: Colors.white),
              child: Row(
                children: [
                  if (_selectedIcon != null) ...[
                    Icon(
                      crowdActionCommitmentIcons[_selectedIcon],
                      size: 18,
                      color: kAccentColor,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        _selectedIcon!,
                        style: CollactionTextStyles.body,
                        softWrap: false,
                      ),
                    ),
                  ] else
                    const Expanded(
                      child: Text(""),
                    ),
                  SizedBox(
                    width: 21,
                    child: Icon(
                      _showPopup ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: kBlackPrimary300,
                    ),
                  ),
                ],
              ),
              onPressed: () => setState(() {
                if (!widget.readOnly) {
                  _showPopup = !_showPopup;
                }
              }),
            ),
            if (_showPopup)
              fieldPopup(
                IconSearch(
                  onIconSelected: (String selectedIcon) => setState(() {
                    _selectedIcon = selectedIcon;
                    widget.validationCallback == null
                        ? _validationOutput = ValidationOutput(error: false)
                        : _validationOutput =
                            widget.validationCallback!(_selectedIcon);
                    _showPopup = false;
                    widget.callback!(_validationOutput);
                  }),
                ),
                onTapOutside: _closePopup,
                width: 200,
                height: 300,
                offset: 0,
              ),
          ],
        ),
      ),
    );
  }

  void _closePopup() {
    setState(() {
      _showPopup = false;
    });
  }
}
