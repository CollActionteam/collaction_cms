import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/dummy_data.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/expandable_card_list.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/previousNextButton.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../../../theme/constants.dart';

class CommitmentListPages extends StatefulWidget {
  final double fullWidth;
  const CommitmentListPages({super.key, required this.fullWidth});

  @override
  State<CommitmentListPages> createState() => _CommitmentListPagesState();
}

class _CommitmentListPagesState extends State<CommitmentListPages> {
  final PageController controller = PageController();
  int _currentPage = 0;
  List<Widget> pages = [];
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    buildPages(dummyData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              buttonAction: () =>
                  controller.previousPage(duration: _kDuration, curve: _kCurve),
            ),
            SelectableText(
              "Page ${_currentPage + 1} of ${pages.length.toString()}",
              style: CollactionTextStyles.captionStyleLight,
            ),
            PreviousNextbutton(
              buttonText: 'Next',
              buttonAction: () =>
                  controller.nextPage(duration: _kDuration, curve: _kCurve),
            ),
          ],
        ),
        SizedBox(height: widget.fullWidth - 100, child: buildPages(dummyData)),
      ],
    );
  }

  Widget buildPages(List itemsList) {
    pages.clear();
    List<List> itemLists = itemsList.slices(4).toList();
    for (var i = 0; i < itemLists.length; i++) {
      ExpandableCardList item = ExpandableCardList(
        itemList: itemLists[i],
        height: widget.fullWidth - 100,
      );
      pages.add(item);
    }
    return PageView.builder(
      controller: controller,
      itemCount: pages.length,
      itemBuilder: (BuildContext context, int index) {
        return pages[index % pages.length];
      },
      onPageChanged: (page) => setState(() {
        _currentPage = page;
      }),
    );
  }
}
