import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlocksRadioTable extends StatelessWidget {
  final List<Commitment> commitmentsToSelect;
  const BlocksRadioTable({
    Key? key,
    required this.commitmentsToSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 230,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFDADADA),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SelectableText(
                "LABEL",
                style: CollactionTextStyles.body,
              ),
              const Spacer(),
              SvgPicture.asset(
                width: 18,
                "assets/icons/disabled.svg",
                color: Colors.grey[600],
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: commitmentsToSelect.length,
              itemBuilder: (context, index) {
                return Text(commitmentsToSelect[index].label);
              },
            ),
          )
        ],
      ),
    );
  }
}
