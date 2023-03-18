import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class ErrorNotification extends StatefulWidget {
  final String errorMessage;

  const ErrorNotification({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  State<ErrorNotification> createState() => _ErrorNotificationState();
}

class _ErrorNotificationState extends State<ErrorNotification> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Card(
        color: kLightBackgroundGreyColor,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            ClipRect(
              child: Container(
                width: 6,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Icon(Icons.cancel_outlined, color: Colors.red),
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
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
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
                      color: kBlackPrimary300,
                      fontSize: 12,
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
