import 'dart:math' as math;

import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_form_controller.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assigned_commitments/commitment_item_form.dart';
import 'package:collaction_cms/presentation/shared/buttons/button_outlined.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

enum CommitmentItemType { simple, addButton, statusChecker }

class CommitmentItem extends StatefulWidget {
  const CommitmentItem({
    super.key,
    required this.iconData,
    required this.label,
    required this.commitmentItemType,
  });

  final IconData iconData;
  final String label;
  final CommitmentItemType commitmentItemType;

  @override
  State<CommitmentItem> createState() => _CommitmentItemState();
}

class _CommitmentItemState extends State<CommitmentItem>
    with SingleTickerProviderStateMixin {
  bool? _itemStatusFields = true;
  bool _isExpanded = false;

  CommitmentFormController _commitmentFormController =
      CommitmentFormController();

  late AnimationController _dropdownController;
  late Animation<double> _dropdownAnimation;

  @override
  void initState() {
    super.initState();
    _dropdownController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _dropdownAnimation = Tween<double>(begin: math.pi, end: 2 * math.pi)
        .animate(_dropdownController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _dropdownController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDADADA)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 53,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF9F9F9),
                  ),
                  child: Icon(
                    size: 20,
                    widget.iconData,
                    color: kAccentColor,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 150,
                  child: SelectableText(
                    widget.label,
                    style: CollactionTextStyles.bodyLabelRegular,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: 110,
                  alignment: Alignment.center,
                  child: _returnWidget(widget.commitmentItemType),
                ),
                widget.commitmentItemType != CommitmentItemType.simple
                    ? Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;

                              if (_isExpanded == true) {
                                _dropdownController.forward();
                              } else {
                                _dropdownController.reverse();
                              }
                            });
                          },
                          overlayColor: MaterialStateProperty.all(
                              Colors.teal[100]!.withOpacity(0.2)),
                          hoverColor: Colors.teal[100]!.withOpacity(0.2),
                          child: Transform.rotate(
                            angle: _dropdownAnimation.value,
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF585858),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Visibility(
            visible: _isExpanded,
            child: const Divider(
              height: 2,
              color: Color(0xFFDADADA),
            ),
          ),
          Visibility(
            visible: _isExpanded,
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: CommitmentItemForm(
                controller: _commitmentFormController,
                backgroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _returnWidget(CommitmentItemType commitmentItemType) {
    if (commitmentItemType == CommitmentItemType.simple) {
      return const SizedBox.shrink();
    }

    if (commitmentItemType == CommitmentItemType.addButton) {
      return SmallOutlinedButton(
        smallOutlinedButtonType: SmallOutlinedButtonType.add,
        callback: () => {},
      );
    }

    if (commitmentItemType == CommitmentItemType.statusChecker) {
      if (_itemStatusFields == true) {
        return const Icon(
          Icons.check_circle_rounded,
          color: addOutlinedColor,
          size: 15,
        );
      } else {
        return const Icon(
          Icons.remove_circle_rounded,
          color: Color(0xFFBCBCBC),
          size: 15,
        );
      }
    }

    return const SizedBox.shrink();
  }
}
