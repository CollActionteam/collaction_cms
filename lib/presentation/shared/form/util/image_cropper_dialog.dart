import 'dart:typed_data';

import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

Future<Uint8List?> showImageCropperModal(
  BuildContext context,
  Size targetSize,
  Uint8List image, {
  Function? callback,
  double horizontalPadding = 24,
  double cropperWidth = 400,
  double cropperMargin = 30,
}) async {
  CropController controller = CropController();
  double aspectRatio = targetSize.width / targetSize.height;
  final height = cropperWidth / aspectRatio;
  final croppercropperWidth = cropperWidth - 2 * cropperMargin;
  final cropperHeight = height - 2 * cropperMargin;

  return showDialog<Uint8List>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: cropperWidth + horizontalPadding * 2,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 74,
                      child: const Text(
                        "Crop",
                        style: CollactionTextStyles.titleStyleCMS,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        width: cropperWidth,
                        height: height,
                        child: Stack(
                          children: [
                            Crop(
                              baseColor: Colors.black,
                              radius: 5,
                              image: image,
                              onCropped: (Uint8List image) =>
                                  Navigator.of(context).pop(
                                image,
                              ),
                              controller: controller,
                              aspectRatio: aspectRatio,
                              interactive: true,
                              initialSize: 1.0,
                              fixArea: true,
                              cornerDotBuilder: (size, edgeAlignment) =>
                                  const SizedBox.shrink(),
                              initialAreaBuilder: (rect) {
                                return Rect.fromLTRB(
                                  rect.left + cropperMargin,
                                  rect.top + cropperMargin,
                                  rect.right - cropperMargin,
                                  rect.bottom - cropperMargin,
                                );
                              },
                            ),
                            Positioned(
                              right: cropperMargin,
                              bottom: cropperMargin,
                              child: IgnorePointer(
                                child: Container(
                                  width: croppercropperWidth,
                                  height: cropperHeight,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: kBlackPrimary0,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 88,
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          CollActionButtonRectangle.wrapped(
                            text: "Confirm",
                            onPressed: () => controller.crop(),
                            width: 157,
                            height: 37,
                            padding: 0,
                          ),
                          CollActionButtonRectangle.wrapped(
                            text: "Cancel",
                            onPressed: () => Navigator.of(context).pop(null),
                            width: 157,
                            height: 37,
                            padding: 0,
                            inverted: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
