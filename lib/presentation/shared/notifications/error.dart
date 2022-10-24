import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class ErrorNotification extends StatefulWidget {
  ErrorNotification({
    Key? key,
    required this.errorMessage
    }) : super(key: key);

    final String errorMessage;

  @override
  State<ErrorNotification> createState() => _ErrorNotificationState();
}

class _ErrorNotificationState extends State<ErrorNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Card(
        color: kLightBackgroundGreyColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            ClipRect(
              child: Container(
                width: 6,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)
                  )
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Icon(
              Icons.cancel_outlined,
              color: Colors.red
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: const SelectableText(
                      "Error",
                      style: TextStyle(
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: SelectableText(
                    "${widget.errorMessage}.",
                    style: const TextStyle(
                      color: kTextColor,
                      fontFamily: "Rubik",
                      fontSize: 12
                    ),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}