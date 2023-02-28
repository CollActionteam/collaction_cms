import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/shared/form/form_field.dart';
import 'package:collaction_cms/presentation/shared/form/util/country_search.dart';
import 'package:collaction_cms/presentation/shared/form/util/field_popup.dart';
import 'package:collaction_cms/presentation/shared/utils/map_domain_presentation/map_value_validators.dart';
import 'package:collaction_cms/presentation/theme/button.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

class CollActionCountryField extends StatefulWidget {
  final String? label;
  final Location? country;
  final double width;
  final Function? callback;
  final Function? validationCallback;
  final bool readOnly;
  final bool buttonTriggered;

  const CollActionCountryField({
    super.key,
    this.label,
    this.country,
    this.width = double.infinity,
    this.callback,
    this.validationCallback,
    this.readOnly = false,
    this.buttonTriggered = false,
  });

  @override
  State<CollActionCountryField> createState() => _CollActionCountryFieldState();
}

class _CollActionCountryFieldState extends State<CollActionCountryField> {
  late MapValidationOutput _mapValidationOutput;
  CountryDetails? _selectedCountry;
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    widget.validationCallback == null
        ? _mapValidationOutput = MapValidationOutput(error: false, output: "")
        : _mapValidationOutput =
            mapValidation(widget.validationCallback!(widget.country));
  }

  @override
  Widget build(BuildContext context) {
    return CollActionFormField(
      readOnly: widget.readOnly,
      error: widget.buttonTriggered && _mapValidationOutput.error
          ? _mapValidationOutput.output
          : null,
      label: widget.label,
      width: widget.width,
      child: SizedBox(
        height: 32,
        child: Stack(
          children: [
            TextButton(
              style: formFieldButtonStyle(readOnly: widget.readOnly),
              child: Row(
                children: [
                  if (_selectedCountry != null) ...[
                    Image.asset(
                      'icons/flags/png/${_selectedCountry!.alpha2Code!.toLowerCase()}.png',
                      package: 'country_icons',
                      height: 18.0,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        _selectedCountry!.name!,
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
                CountrySearch(
                  onCountrySelected: (CountryDetails countryDetails) =>
                      setState(() {
                    _selectedCountry = countryDetails;
                    widget.validationCallback == null
                        ? _mapValidationOutput =
                            MapValidationOutput(error: false, output: "")
                        : _mapValidationOutput = mapValidation(
                            widget.validationCallback!(_selectedCountry));
                    _showPopup = false;
                  }),
                ),
                onTapOutside: _closePopup,
                width: widget.width,
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
