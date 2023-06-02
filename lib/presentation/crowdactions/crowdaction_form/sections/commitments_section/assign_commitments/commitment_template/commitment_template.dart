import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/dummy_data.dart';

import 'package:collaction_cms/presentation/shared/extra/tags_pills.dart';
import 'package:flutter/material.dart';

import '../../../../../../theme/constants.dart';
import 'commitment_template_widgets/expandable_card_list.dart';
import 'commitment_template_widgets/previousNextButton.dart';

class CommitmentTemplate extends StatefulWidget {
  final double fullWidth;
  const CommitmentTemplate({super.key, required this.fullWidth});

  @override
  State<CommitmentTemplate> createState() => _CommitmentTemplateState();
}

class _CommitmentTemplateState extends State<CommitmentTemplate> {
  List<String> tags = [];
  @override
  Widget build(BuildContext context) {
    List<DummyModel> itemList = dummyData;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.add_circle_outline),
                hintText: 'Search commitmets templates tags',
                hintStyle: CollactionTextStyles.captionStyleLight,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  tags.add(value);
                });
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Selected tags:",
              style: CollactionTextStyles.captionStyleLight,
            ),
          ),
          buildTagsRow(tags),
          const Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SelectableText(
                "Commitments",
                style: CollactionTextStyles.captionStyleBold,
              ),
              Container(
                margin: const EdgeInsets.only(left: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SelectableText(
                  dummyData.length.toString(),
                  style: CollactionTextStyles.captionStyle,
                ),
              ),
              const Spacer(),
              PreviousNextbutton(
                buttonText: 'Previous',
                buttonAction: () {},
              ),
              const SelectableText(
                "Page 1 of 5",
                style: CollactionTextStyles.captionStyleLight,
              ),
              PreviousNextbutton(
                buttonText: 'Next',
                buttonAction: () {},
              ),
            ],
          ),
          ExpandableCardList(
            itemList: itemList,
            height: widget.fullWidth - 100,
          )
        ],
      ),
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
