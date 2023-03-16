import 'dart:typed_data';

import 'package:collaction_cms/domain/core/value_validators.dart';
import 'package:collaction_cms/presentation/shared/form/form_field.dart';
import 'package:collaction_cms/presentation/shared/form/util/image_cropper_dialog.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class ImageField extends StatefulWidget {
  final String label;
  final String caption;
  final double width;
  final Size? imageSize;
  final Function? callback;
  final Function? validationCallback;
  final bool readOnly;
  final bool buttonTriggered;

  const ImageField({
    super.key,
    required this.label,
    this.caption = "Image should be a PNG or JPEG file. "
        "Dimensions of the image should be 500 x 600 px",
    this.width = double.infinity,
    this.imageSize,
    this.callback,
    this.validationCallback,
    this.readOnly = false,
    this.buttonTriggered = false,
  });

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  final List<String> mime = [
    'image/jpeg',
    'image/png',
  ];
  late DropzoneViewController _controller;
  late ValidationOutput _validationOutput;
  bool _highlighted = false;
  bool _loading = false;
  Uint8List? _image;
  String message = "Drag and drop your files here or choose file";

  @override
  Widget build(BuildContext context) {
    return CollActionFormField(
      readOnly: widget.readOnly,
      error: widget.buttonTriggered && _validationOutput.error
          ? _validationOutput.output
          : null,
      label: widget.label,
      caption: widget.caption,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        color: const Color(0x80707070),
        dashPattern: const [4, 4],
        strokeWidth: 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: widget.width,
            height: 87,
            color: _highlighted ? const Color(0x20A0A0A0) : Colors.transparent,
            child: Stack(
              children: [
                DropzoneView(
                  operation: DragOperation.copy,
                  cursor: _loading ? null : CursorType.grab,
                  onCreated: (ctrl) => _controller = ctrl,
                  onHover: () => setState(
                    () => _highlighted = true,
                  ),
                  onLeave: () => setState(
                    () => _highlighted = false,
                  ),
                  onDrop: (event) async {
                    await _processUploadedImage(event);
                    setState(() {
                      _loading = false;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    var files = await _controller.pickFiles(mime: mime);
                    if (files.isNotEmpty) {
                      await _processUploadedImage(files[0]);
                    }
                    setState(() {
                      _loading = false;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Center(
                    child: _loading
                        ? const CircularProgressIndicator(
                            color: kBlackPrimary200,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.file_upload_outlined,
                                color: kBlackPrimary300,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                message,
                                style: CollactionTextStyles.body14,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateExtension(String s) {
    return s.toLowerCase().endsWith("png") ||
        s.toLowerCase().endsWith("jpg") ||
        s.toLowerCase().endsWith("jpeg");
  }

  void _validate() {
    widget.validationCallback == null
        ? _validationOutput = ValidationOutput(error: false)
        : _validationOutput = widget.validationCallback!(_image);
    widget.callback == null
        ? null
        : widget.callback!(_validationOutput.error ? null : _image);
  }

  Future<void> _processUploadedImage(dynamic file) async {
    setState(() {
      _highlighted = false;
      _loading = true;
    });

    if (!_validateExtension(file.name)) {
      message = "File type invalid.";
      return;
    }

    _image = await _controller.getFileData(file);
    if (!mounted) {
      message = "Image could not be loaded.";
      return;
    }

    if (widget.imageSize != null) {
      _image = await showImageCropperModal(
        context,
        widget.imageSize!,
        _image!,
      );
    }

    if (_image != null) {
      _validate();
      message = "Uploaded image: ${file.name}";
    }
  }
}
