import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class StatusTag extends StatelessWidget {

  StatusTag._(
    Key? key,
    this.status,
    this.backgroundColor,
    this.textColor,
    this.text
  ) : super(key: key);

  factory StatusTag({Key? key, required Status status}) {
    Color colorBackground;
    Color colorText;
    String factoryText;
    
    switch(status) {
      case Status.started : {
        colorBackground = kStartedTagBackground;
        colorText = kStartedTagText;
        factoryText = "Started";
      } break;
      case Status.waiting : {
        colorBackground =  kWaitingTagBackground;
        colorText = kWaitingTagText;
        factoryText = "Waiting";
      } break;
      case Status.ended : {
        colorBackground =  kEndedTagBackground;
        colorText = kEndedTagText;
        factoryText = "Ended";
      } break;
    }

    return StatusTag._(key, status, colorBackground, colorText, factoryText);
  }

  final Status status;
  final Color backgroundColor;
  final Color textColor;
  final String text;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 27,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4)
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontFamily: "Rubik",
            ),
          ),
        ),
      ],
    );
  }
}