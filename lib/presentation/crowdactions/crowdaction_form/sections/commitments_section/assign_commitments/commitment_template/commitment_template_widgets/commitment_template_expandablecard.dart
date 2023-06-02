import 'package:collaction_cms/presentation/shared/buttons/button_outlined.dart';
import 'package:flutter/material.dart';
import '../../../../../../../theme/constants.dart';

class ExpandableTemplateCard extends StatefulWidget {
  final String label;
  final IconData icons;
  final List<String> tags;
  final String description;
  final String points;

  const ExpandableTemplateCard(
      {super.key,
      required this.label,
      required this.icons,
      required this.tags,
      required this.description,
      required this.points});

  @override
  State<ExpandableTemplateCard> createState() => _ExpandableTemplateCardState();
}

class _ExpandableTemplateCardState extends State<ExpandableTemplateCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: ExpansionTile(
        backgroundColor: kScaffoldColorWhite,
        collapsedBackgroundColor: kScaffoldColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: kBlackPrimary100,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: kBlackPrimary100,
          ),
        ),
        iconColor: kBlackPrimary300,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kBlackPrimary0,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    widget.icons,
                    color: kAccentColor,
                  ),
                ),
              ),
            ),
            SelectableText(
              widget.label,
              style: CollactionTextStyles.bodyLabelRegular,
            ),
            const Spacer(),
            const SmallOutlinedButton(
              smallOutlinedButtonType: SmallOutlinedButtonType.add,
              callback: null,
            )
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
                  children: [
                    SelectableText.rich(TextSpan(
                        text: "Tags: ",
                        style: CollactionTextStyles.bodyMedium14,
                        children: [
                          TextSpan(
                            text: widget.tags.toString(),
                            style: CollactionTextStyles.body14,
                          )
                        ])),
                    const SizedBox(height: 5),
                    SelectableText.rich(TextSpan(
                        text: "Description: ",
                        style: CollactionTextStyles.bodyMedium14,
                        children: [
                          TextSpan(
                            text: widget.description,
                            style: CollactionTextStyles.body14,
                          )
                        ])),
                    const SizedBox(height: 5),
                    SelectableText.rich(TextSpan(
                        text: "Points: ",
                        style: CollactionTextStyles.bodyMedium14,
                        children: [
                          TextSpan(
                            text: widget.points,
                            style: CollactionTextStyles.body14,
                          )
                        ])),
                    const SizedBox(height: 5),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
