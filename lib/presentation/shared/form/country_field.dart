import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/shared/form/form_field.dart';
import 'package:collaction_cms/presentation/shared/form/util/country_search.dart';
import 'package:collaction_cms/presentation/shared/form/util/field_popup.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

class CollActionCountryField extends StatefulWidget {
  final String? label;
  Location? country;
  double width;
  final Function? callback;
  final bool readOnly;

  CollActionCountryField({
    super.key,
    this.label,
    this.country,
    this.width = double.infinity,
    this.callback,
    this.readOnly = false,
  });

  @override
  State<CollActionCountryField> createState() => _CollActionCountryFieldState();
}

class _CollActionCountryFieldState extends State<CollActionCountryField> {
  CountryDetails? _selectedCountry;
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CollActionFormField(
      label: widget.label,
      width: widget.width,
      child: SizedBox(
        height: 32,
        child: Stack(
          children: [
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0x80707070)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(
                    double.infinity,
                    32,
                  ),
                ),
              ),
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
                _showPopup = true;
              }),
            ),
            if (_showPopup)
              fieldPopup(
                CountrySearch(
                  onCountrySelected: (CountryDetails countryDetails) =>
                      setState(() {
                    _selectedCountry = countryDetails;
                    _showPopup = false;
                  }),
                ),
                onTapOutside: closePopup,
                width: widget.width,
                height: 300,
                offset: 32,
              ),
          ],
        ),
      ),
    );
  }

  void closePopup() {
    setState(() {
      _showPopup = false;
    });
  }
}
