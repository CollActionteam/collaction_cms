import 'dart:typed_data';

import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/form/form_header.dart';
import 'package:collaction_cms/presentation/shared/form/image_field.dart';
import 'package:flutter/widgets.dart';

class CrowdActionImagesForm extends StatefulWidget {
  final double width;
  final bool buttonTriggered;

  const CrowdActionImagesForm({
    super.key,
    this.width = double.infinity,
    this.buttonTriggered = false,
  });

  @override
  State<CrowdActionImagesForm> createState() => _CrowdActionImagesFormState();
}

class _CrowdActionImagesFormState extends State<CrowdActionImagesForm> {
  Uint8List? cardImage;
  bool cardImageSet = false;
  Uint8List? bannerImage;
  bool bannerImageSet = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const FormHeader(title: "Images"),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              children: [
                ImageField(
                  label: "Card",
                  buttonTriggered: widget.buttonTriggered,
                  validationCallback: validateEmptyField,
                  callback: (Uint8List image) => cardImage = image,
                  imageSize: const Size(375, 215),
                ),
                ImageField(
                  label: "Banner",
                  buttonTriggered: widget.buttonTriggered,
                  validationCallback: validateEmptyField,
                  callback: (Uint8List image) => bannerImage = image,
                  imageSize: const Size(415, 310),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
