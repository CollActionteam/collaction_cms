import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../domain/core/i_settings_repository.dart';
import '../../../infrastructure/core/injection.dart';
import '../../theme/constants.dart';

class ImageComposition extends StatelessWidget {
  const ImageComposition(
      {Key? key,
      required this.label,
      required this.displayableUrl,
      required this.width,
      required this.height,
      required this.fallback})
      : super(key: key);

  final String label;
  final Widget fallback;
  final String? displayableUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<ISettingsRepository>().staticEndpointUrl,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              label,
              style: CollactionTextStyles.bodySemiBold,
            ),
            const SizedBox(height: 12),
            displayableUrl != null
                ? Container(
                    width: width,
                    height: height,
                    alignment: Alignment.topLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: snapshot.hasData
                          ? ImageNetwork(
                              duration: 200,
                              curve: Curves.linear,
                              onLoading: const CircularProgressIndicator(
                                color: kAccentColor,
                              ),
                              image: "${snapshot.data}/$displayableUrl",
                              width: width,
                              height: height,
                            )
                          : const SizedBox.shrink(),
                    ),
                  )
                : fallback
          ],
        );
      },
    );
  }
}
