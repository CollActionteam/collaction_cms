import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class InfoNotification extends StatelessWidget {
  const InfoNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Card(
        color: kLightBackgroundGreyColor,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 20),
            Icon(Icons.info_outline_rounded, color: kWarningColor),
            SizedBox(width: 12),
            Expanded(
              child: SelectableText(
                "Don’t forget to tell guests admin to check their spam inbox!",
                style: CollactionTextStyles.captionStyle,
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
      ),
    );
  }
}
