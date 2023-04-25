import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/shared/filters/dropdown.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class AddBlocksSelect extends StatelessWidget {
  final bool? isLoading;
  final List<Commitment> commitments;
  final Function callback;
  const AddBlocksSelect({
    Key? key,
    required this.isLoading,
    required this.commitments,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      alignment: Alignment.center,
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SelectableText(
            "Add Blocks",
            style: CollactionTextStyles.headline,
          ),
          const SizedBox(height: 15),
          const SelectableText(
            '''Add Blocking relations between commitments. E.g if a user picks a commitment "A", commitment "B" and "C" get blocked.''',
            style: CollactionTextStyles.body14,
          ),
          const SizedBox(
            height: 7.5,
          ),
          const SelectableText(
            '''In Block list, If the radio button is set to true means that the commitment is being blocked by the selected commitment.''',
            style: CollactionTextStyles.body14,
          ),
          const SizedBox(height: 15),
          const SelectableText(
            "Select a commitment:",
            style: CollactionTextStyles.bodyMedium14,
          ),
          SizedBox(
            width: 192,
            child: DropdownField(
              getValueCallback: (String value) {
                var commitment = commitments
                    .where((commitment) => commitment.label == value)
                    .toList()[0];
                callback(commitment);
              },
              isLoading: isLoading,
              primaryColor: true,
              backgroundColor: Colors.white,
              items: commitments.map((e) => e.label).toList(),
              borderStyle: CollActionBorderStyles.formFieldBorderSide,
            ),
          ),
        ],
      ),
    );
  }
}
