import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class CommitmentItem extends StatelessWidget {
  CommitmentItem({
    Key? key,
    this.iconData,
    required this.label,
    required this.description,
    required this.tags,
    required this.points
    }) : 
    super(key: key) {

      tagsPresentationOutput = _tagsPresentationConverter(tags);
    }

    final IconData? iconData;
    final String label;
    final String description;
    final List<String> tags;
    final int points;
    String tagsPresentationOutput = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0XFFE7E7E7)
          )
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, left: 15),
            alignment: Alignment.topCenter,
            child: Icon(
              iconData,
              color: kAccentColor,
            ),
          ),
          const SizedBox(width: 20),
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  label,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Rubik",
                      color: Color(0xFF585858),
                      fontWeight: FontWeight.w700,
                      
                    )
                ),
                const SizedBox(height: 5),
                SelectableText(
                  description,
                  style: CollactionTextStyles.body,
                ),
                const SizedBox(height: 5),
                SelectableText.rich(
                  TextSpan(
                    text: "Tags: ",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Rubik",
                      color: Color(0xFF585858),
                      fontWeight: FontWeight.w500,
                      
                    ),
                    children: [
                      TextSpan(
                        text: tagsPresentationOutput,
                        style: CollactionTextStyles.body
                      )
                    ]
                  )
                ),
                const SizedBox(height: 5),
                SelectableText(
                  "Points: $points",
                  style: CollactionTextStyles.body,
                  
                ),
                const SizedBox(height:10)
              ],
            ),
          )
        ],
      ),
    );
  }

  String _tagsPresentationConverter(List<String> tags) {
    String output = '';
    String bracketsWrapper = '';

    for(var tag in tags) {
      output.isEmpty ? output = tag
        : output += ', $tag';
    }

    bracketsWrapper = "[ $output ]";
    return bracketsWrapper;
  }
}