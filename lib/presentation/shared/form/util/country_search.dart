import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

class CountrySearch extends StatefulWidget {
  final Function? onCountrySelected;

  const CountrySearch({
    super.key,
    this.onCountrySelected,
  });

  @override
  State<CountrySearch> createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  final _countryCodes =
      CountryCodes.countryCodes().whereType<CountryDetails>().toList();
  late List<CountryDetails> _countries;

  @override
  void initState() {
    super.initState();
    _countries = List<CountryDetails>.from(
      _countryCodes
        ..sort(
          (a, b) => a.alpha2Code?.compareTo(b.alpha2Code ?? "") == 1 ? 1 : -1,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: TextField(
                    autofocus: true,
                    style: CollactionTextStyles.bodyMedium14,
                    cursorColor: const Color(0xFF585858),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: kAccentColor,
                        size: 20,
                      ),
                      contentPadding: EdgeInsets.all(4),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlackPrimary300,
                          width: 0.5,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlackPrimary300,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlackPrimary300,
                          width: 0.5,
                        ),
                      ),
                    ),
                    onChanged: _searchCountry,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final country = _countries[index];

                return InkWell(
                  onTap: () {
                    if (widget.onCountrySelected != null) {
                      widget.onCountrySelected!(country);
                    }
                  },
                  child: SizedBox(
                    height: 28,
                    child: Row(
                      children: [
                        Image.asset(
                          'icons/flags/png/${country.alpha2Code!.toLowerCase()}.png',
                          package: 'country_icons',
                          width: 28.0,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            country.name!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _countries.length,
            ),
          )
        ],
      ),
    );
  }

  /// Find country name matching search pattern
  void _searchCountry(String text) {
    _countries.clear();

    setState(() {
      if (text.isEmpty) {
        _countries.addAll(_countryCodes);
      } else {
        _countries.addAll(
          _countryCodes.where(
            (country) =>
                country.name?.toLowerCase().contains(text.toLowerCase()) ==
                true,
          ),
        );
      }
    });
  }
}
