import 'package:collaction_cms/presentation/core/icons/collaction_icons.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/commitment_template_expandablecard.dart';
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
                children: const [ExpandableTemplateCard()],
              ),
            ),
          )
        ],
      ),
    );
  }
}
