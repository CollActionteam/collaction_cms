import 'package:flutter/material.dart';

import '../../../../../../../core/icons/collaction_icons.dart';
import '../../../../../../../theme/constants.dart';

class ExpandableTemplateCard extends StatefulWidget {
  const ExpandableTemplateCard({super.key});

  @override
  State<ExpandableTemplateCard> createState() => _ExpandableTemplateCardState();
}

class _ExpandableTemplateCardState extends State<ExpandableTemplateCard> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: kBlackPrimary300,
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              CollactionIcons.vegan,
              color: kAccentColor,
            ),
          ),
          const SelectableText(
            "5 days per week",
            style: CollactionTextStyles.bodyLabelRegular,
          ),
          const Spacer(),
          OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                side: MaterialStateProperty.all(const BorderSide(
                  color: kAccentColor,
                )),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              child: const Text(
                "Add",
                style: CollactionTextStyles.addButton,
              ))
        ],
      ),
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SelectableText.rich(TextSpan(
                      text: "Tags: ",
                      style: CollactionTextStyles.bodyMedium14,
                      children: [
                        TextSpan(
                          text: "[Diet, Days, Veganuary ]",
                          style: CollactionTextStyles.body14,
                        )
                      ])),
                  SizedBox(height: 5),
                  SelectableText.rich(TextSpan(
                      text: "Description: ",
                      style: CollactionTextStyles.bodyMedium14,
                      children: [
                        TextSpan(
                          text: "Commit to eating a vegan diet 4 day per week",
                          style: CollactionTextStyles.body14,
                        )
                      ])),
                  SizedBox(height: 5),
                  SelectableText.rich(TextSpan(
                      text: "Points: ",
                      style: CollactionTextStyles.bodyMedium14,
                      children: [
                        TextSpan(
                          text: "20",
                          style: CollactionTextStyles.body14,
                        )
                      ])),
                  SizedBox(height: 5),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
