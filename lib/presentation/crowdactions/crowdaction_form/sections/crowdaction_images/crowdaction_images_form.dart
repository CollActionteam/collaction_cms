import 'dart:typed_data';

import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/crowdaction_images/crowdaction_images_controller.dart';
import 'package:collaction_cms/presentation/shared/form/form_header.dart';
import 'package:collaction_cms/presentation/shared/form/image_field.dart';
import 'package:flutter/widgets.dart';

class CrowdActionImagesForm extends StatefulWidget {
  final double width;
  final bool buttonTriggered;
  final CrowdActionImagesFormController controller;

  const CrowdActionImagesForm({
    super.key,
    this.width = double.infinity,
    this.buttonTriggered = false,
    required this.controller,
  });

  @override
  State<CrowdActionImagesForm> createState() => _CrowdActionImagesFormState();
}

class _CrowdActionImagesFormState extends State<CrowdActionImagesForm> {
  Uint8List? cardImage;
  Uint8List? bannerImage;

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
                  callback: (Uint8List? image) =>
                      widget.controller.setValidationOutput(
                    'card',
                    ValidationOutput(error: false, output: image),
                  ),
                  aspectRatio: 16 / 9,
                ),
                ImageField(
                  label: "Banner",
                  buttonTriggered: widget.buttonTriggered,
                  callback: (Uint8List? image) =>
                      widget.controller.setValidationOutput(
                    'banner',
                    ValidationOutput(error: false, output: image),
                  ),
                  aspectRatio: 16 / 9,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
