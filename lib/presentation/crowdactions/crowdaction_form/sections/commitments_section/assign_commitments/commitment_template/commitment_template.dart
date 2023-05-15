import 'package:collaction_cms/presentation/core/icons/collaction_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../../theme/constants.dart';

class CommitmentTemplate extends StatefulWidget {
  final double fullWidth;
  const CommitmentTemplate({super.key, required this.fullWidth});

  @override
  State<CommitmentTemplate> createState() => _CommitmentTemplateState();
}

class _CommitmentTemplateState extends State<CommitmentTemplate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.add_circle_outline),
                hintText: 'Search commitmets templates tags',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Selected tags:"),
          ),
          Row(
            children: const [
              Chip(
                avatar: Icon(
                  Icons.close,
                  weight: 10,
                ),
                label: Text("Text"),
              ),
              Chip(label: Text("Text")),
              Chip(label: Text("Text")),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const SelectableText("Commitments"),
              const SelectableText("8"),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Previous",
                    style: CollactionTextStyles.body,
                  )),
              const SelectableText("Page 1 of 5"),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Next",
                    style: CollactionTextStyles.body,
                  )),
            ],
          ),
          SizedBox(
            height: widget.fullWidth - 79,
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ExpansionTile(
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
                        const Text(
                          "5 days per week",
                          style: CollactionTextStyles.body,
                        ),
                        const Spacer(),
                        OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(const BorderSide(
                                color: kAccentColor,
                              )),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
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
                          children: const [
                            Divider(),
                            Text(
                              "Tags: [Diet, Days, Veganuary ]",
                              style: CollactionTextStyles.bodyBold,
                            ),
                            Text(
                                "Description: Commit to eating a vegan diet 4 day per week",
                                style: CollactionTextStyles.body),
                            Text("Points: 20",
                                style: CollactionTextStyles.body),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
