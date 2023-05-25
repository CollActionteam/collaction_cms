import 'package:collaction_cms/presentation/core/icons/collaction_icons.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/commitment_template_expandablecard.dart';
import 'package:collaction_cms/presentation/shared/extra/tags_pills.dart';
import 'package:flutter/material.dart';

import '../../../../../../theme/constants.dart';
import 'commitment_template_widgets/previousNextButton.dart';

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
                hintStyle: CollactionTextStyles.captionStyleLight,
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
            child: Text(
              "Selected tags:",
              style: CollactionTextStyles.captionStyleLight,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TagPill(value: "Days", callback: () {}),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TagPill(value: "Veganuary", callback: () {}),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TagPill(value: "Diet", callback: () {}),
              ),
            ],
          ),
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
                child: const SelectableText(
                  "8",
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
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: SizedBox(
              height: widget.fullWidth - 100,
              child: SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    ExpandableTemplateCard(),
                    ExpandableTemplateCard(),
                    ExpandableTemplateCard(),
                    ExpandableTemplateCard(),
                    ExpandableTemplateCard(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
