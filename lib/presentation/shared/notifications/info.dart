import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:collaction_admin/presentation/theme/text.dart';
import 'package:flutter/material.dart';

class InfoNotification extends StatelessWidget {
  const InfoNotification({
    Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Card(
        color: kLightBackgroundGreyColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            const Icon(
              Icons.info_outline_rounded,
              color: kWarningColor
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                child: const SelectableText(
                  "Don’t forget to tell guests admin to check their spam inbox!",
                  style: CollactionTextStyles.captionStyle,
                ),
              ),
            ),
            const SizedBox(width: 20)
          ],
        ),

      )
    );
  }
}