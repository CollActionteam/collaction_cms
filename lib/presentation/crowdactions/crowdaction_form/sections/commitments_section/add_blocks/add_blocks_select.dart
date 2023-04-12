import 'package:collaction_cms/presentation/shared/filters/dropdown.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class AddBlocksSelect extends StatelessWidget {
  const AddBlocksSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SelectableText(
          "Add Blocks",
          style: CollactionTextStyles.title2Style,
        ),
        const SizedBox(
          height: 10,
        ),
        const SelectableText("Select a commitment:"),
        SizedBox(
          width: 192,
          child: DropdownField(
            primaryColor: true,
            backgroundColor: Colors.white,
            items: const [
              "4 days per week",
              "Commitment item #2",
              "Commitment item #3",
            ],
            borderStyle: CollActionBorderStyles.formFieldBorderSide,
          ),
        )
      ],
    );
  }
}
