import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  const Pagination({
    Key? key,
    required this.paginationInfo,
    required this.callbackPrevious,
    required this.callbackNext
    }) : super(key: key);

    final String paginationInfo;
    final Function callbackPrevious;
    final Function callbackNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.2,
            color: kBlackPrimary400
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionPaginationButton(
            callback: () => callbackPrevious(), 
            text: "Previous"
          ),
          SelectableText(
            paginationInfo,
            style: CollactionTextStyles.body14,
          ),
          ActionPaginationButton(
            callback: () => callbackNext(), 
            text: "Next")
        ],
      ),
    );
  }
}

class ActionPaginationButton extends StatelessWidget {
  const ActionPaginationButton({
    Key? key,
    required this.callback,
    required this.text
    }) : super(key: key);

    final Function callback;
    final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => callback(),
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.2,
              color: kBlackPrimary400
            ),
            borderRadius: BorderRadius.circular(5)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          child: Text(
            text,
            style: CollactionTextStyles.body14,
          ),
        ),
      ),
    );
  }
}