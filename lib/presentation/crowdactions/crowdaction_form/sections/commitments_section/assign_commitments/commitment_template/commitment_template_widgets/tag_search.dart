import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../../../shared/extra/tags_pills.dart';
import '../../../../../../../theme/constants.dart';

class TagSearchSection extends StatefulWidget {
  const TagSearchSection({super.key});

  @override
  State<TagSearchSection> createState() => _TagSearchSectionState();
}

class _TagSearchSectionState extends State<TagSearchSection> {
  List<String> tags = ["Days", "Veganuary", "Diet"];
  String hintText = 'Search commitment-template tags';
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        if (focusNode.hasFocus) {
          hintText = '';
        } else {
          hintText = 'Search commitment-template tags';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          child: TextField(
            cursorHeight: 12,
            focusNode: focusNode,
            cursorColor: kBlackPrimary200,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 13.0),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 14.0, bottom: 10),
                child: Icon(
                  Icons.search,
                ),
              ),
              prefixIconColor: kBlackPrimary300,
              suffixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Icon(Icons.add_circle_outline),
              ),
              suffixIconColor: kBlackPrimary300,
              hintText: hintText,
              hintStyle: CollactionTextStyles.captionStyle.copyWith(
                  color: const Color(0xFF707070), fontWeight: FontWeight.w200),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kBlackPrimary100),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kBlackPrimary100),
              ),
            ),
            onSubmitted: (seachedTag) {
              setState(() {
                tags.add(seachedTag);
              });
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 8),
          child: Text(
            "Selected tags:",
            style: CollactionTextStyles.captionStyleLight,
          ),
        ),
        buildTagsRow(tags),
      ],
    );
  }

  Widget buildTagsRow(List<String> tags) {
    List<Widget> rowItems = [];
    for (var i = 0; i < tags.length; i++) {
      Widget rowItem = Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: TagPill(
            value: tags[i],
            callback: () {
              setState(() {
                tags.removeAt(i);
              });
            }),
      );
      rowItems.add(rowItem);
    }
    return Row(
      children: rowItems,
    );
  }
}
