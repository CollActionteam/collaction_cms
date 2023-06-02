import 'package:flutter/material.dart';

import 'commitment_template_expandablecard.dart';

class ExpandableCardList extends StatelessWidget {
  final double height;
  final List itemList;

  const ExpandableCardList(
      {super.key, required this.height, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: ListView.builder(
            itemCount: itemList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ExpandableTemplateCard(
                  label: itemList[index].label,
                  icons: itemList[index].commitmentIcon,
                  tags: itemList[index].tags,
                  description: itemList[index].description,
                  points: itemList[index].points);
            },
          ),
        ),
      ),
    );
  }
}
