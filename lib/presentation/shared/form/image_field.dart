import 'package:collaction_cms/presentation/shared/form/form_field.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class ImageField extends StatefulWidget {
  final String label;
  final String caption;
  final double width;
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
    this.callback,
    this.validationCallback,
    this.readOnly = false,
    this.buttonTriggered = false,
  });

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  late DropzoneViewController _controller;
  bool _highlighted = false;
  Image? image;
  String message = "Drag and drop your files here or choose file";

  @override
  Widget build(BuildContext context) {
    return CollActionFormField(
      readOnly: widget.readOnly,
      error: widget.buttonTriggered ? "err" : null,
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
                  cursor: CursorType.grab,
                  onCreated: (ctrl) => _controller = ctrl,
                  onHover: () => setState(
                    () => _highlighted = true,
                  ),
                  onLeave: () => setState(
                    () => _highlighted = false,
                  ),
                  onDrop: (event) async {
                    setState(() {
                      _highlighted = false;
                    });
                    if (event.name.toLowerCase().endsWith("png") ||
                        event.name.toLowerCase().endsWith("jpg") ||
                        event.name.toLowerCase().endsWith("jpeg")) {
                      final bytes = await _controller.getFileData(event);
                      image = Image.memory(bytes);
                      widget.validationCallback!(image);
                      message = "Uploaded image: ${event.name}";
                      widget.callback!(image);
                    } else {
                      message = "File type invalid.";
                    }
                    setState(() {});
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    var files = await _controller.pickFiles(mime: [
                      'image/jpeg',
                      'image/png',
                    ]);
                    if (files.isNotEmpty) {
                      image = Image.memory(
                        await _controller.getFileData(files[0]),
                      );
                      widget.validationCallback!(image);
                      message = "Uploaded image: ${files[0].name}";
                      widget.callback!(image);
                    }
                    setState(() {});
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Center(
                    child: Column(
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
}
