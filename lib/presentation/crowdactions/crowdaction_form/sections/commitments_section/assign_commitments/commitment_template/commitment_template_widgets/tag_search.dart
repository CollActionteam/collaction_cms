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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.grey,
              suffixIcon: Icon(Icons.add_circle_outline),
              suffixIconColor: Colors.grey,
              hintText: 'Search commitmets templates tags',
              hintStyle: CollactionTextStyles.captionStyleLight,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
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
          padding: EdgeInsets.all(10.0),
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
