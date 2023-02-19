import 'package:collaction_cms/infrastructure/core/settings_repository.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_network/image_network.dart';
import 'package:collaction_cms/domain/core/i_settings_repository.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/infrastructure/core/injection.dart';


class ImageComposition extends StatelessWidget {
  const ImageComposition({
    Key? key,
    required this.label,
    required this.displayableUrl,
    required this.width,
    required this.height,
    required this.fallback
    }) : super(key: key);

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
            const SizedBox(
              height: 12,
            ),
            displayableUrl != null ?
            Container(
              width: width,
              height: height,
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: snapshot.hasData ? ImageNetwork(
                  duration: 200,
                  curve: Curves.linear,
                  onLoading: const CircularProgressIndicator(color: kAccentColor,),
                  image: "${snapshot.data}/$displayableUrl",
                  width: width,
                  height: height,
                ) : const SizedBox.shrink()
              )
            ) :  fallback
          ],
        );
      }
    );
  }
}