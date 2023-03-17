import 'dart:collection';

import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:collaction_cms/presentation/core/icons/icons_map.dart';

class IconSearch extends StatefulWidget {
  final Function? onIconSelected;

  const IconSearch({
    super.key,
    this.onIconSelected,
  });

  @override
  State<IconSearch> createState() => _IconSearchState();
}

class _IconSearchState extends State<IconSearch> {
  late SplayTreeMap<String, dynamic> _sortedMap =
      SplayTreeMap<String, dynamic>.from({});

  @override
  void initState() {
    super.initState();
    _sortedMap =
        SplayTreeMap.from(crowdActionCommitmentIcons, (a, b) => a.compareTo(b));
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
                var key = crowdActionCommitmentIcons.keys.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: () {
                      if (widget.onIconSelected != null) {
                        widget.onIconSelected!(key);
                      }
                    },
                    child: SizedBox(
                      height: 32,
                      child: Row(
                        children: [
                          Icon(
                            crowdActionCommitmentIcons[key],
                            size: 28,
                            color: kAccentColor,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              key,
                              overflow: TextOverflow.ellipsis,
                              style: CollactionTextStyles.body,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: crowdActionCommitmentIcons.length,
            ),
          )
        ],
      ),
    );
  }

  /// Find country name matching search pattern
  void _searchCountry(String text) {
    _sortedMap.clear;

    setState(() {
      if (text.isEmpty) {
        _sortedMap.addAll(crowdActionCommitmentIcons);
      } else {
        _sortedMap.addAll(
          Map.from(crowdActionCommitmentIcons)
            ..removeWhere(
              (key, value) =>
                  key.toLowerCase().contains(text.toLowerCase()) == false,
            ),
        );
      }
    });
  }
}
