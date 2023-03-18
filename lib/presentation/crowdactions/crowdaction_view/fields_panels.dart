import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../shared/composition/image_composition.dart';
import '../../shared/composition/text_composition.dart';
import '../../shared/utils/data_parse/date.dart';
import '../../theme/constants.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({
    Key? key,
    required this.location,
    required this.category,
    required this.subcategory,
    required this.description,
  }) : super(key: key);

  final Location location;
  final String category;
  final String subcategory;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        TextComposition(
          label: "Location:",
          content: location.name,
          textCompositionSize: TextCompositionSize.small,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            TextComposition(
              label: "Category:",
              content: category,
              textCompositionSize: TextCompositionSize.small,
            ),
            const SizedBox(width: 80),
            TextComposition(
              label: "Subcategory:",
              content: subcategory,
              textCompositionSize: TextCompositionSize.small,
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextComposition(
          label: "Description:",
          content: description,
          textCompositionSize: TextCompositionSize.long,
        )
      ],
    );
  }
}

class ImagesPanel extends StatelessWidget {
  const ImagesPanel({Key? key, this.banner, this.card}) : super(key: key);

  final String? banner;
  final String? card;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageComposition(
                label: "Card:",
                displayableUrl: card,
                width: 100,
                height: 128,
                fallback: const SelectableText("Image not found",
                    style: CollactionTextStyles.body)),
            const SizedBox(width: 80),
            ImageComposition(
                label: "Banner:",
                displayableUrl: banner,
                width: 340,
                height: 310,
                fallback: const SelectableText("Image not found",
                    style: CollactionTextStyles.body)),
          ],
        ),
      ],
    );
  }
}

class DatesPanel extends StatelessWidget {
  const DatesPanel(
      {Key? key,
      required this.startAt,
      required this.endAt,
      required this.joinEndAt})
      : super(key: key);

  final DateTime startAt;
  final DateTime endAt;
  final DateTime joinEndAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            TextComposition(
              label: "Start at:",
              content: DateParse.returnCollActionDate(
                  startAt, DateFormatOutput.withYear),
              textCompositionSize: TextCompositionSize.small,
            ),
            const SizedBox(width: 80),
            TextComposition(
                label: "End at:",
                content: DateParse.returnCollActionDate(
                    endAt, DateFormatOutput.withYear),
                textCompositionSize: TextCompositionSize.small)
          ],
        ),
        const SizedBox(height: 20),
        TextComposition(
            label: "Join end at:",
            content: DateParse.returnCollActionDate(
                joinEndAt, DateFormatOutput.withYear),
            textCompositionSize: TextCompositionSize.small)
      ],
    );
  }
}

class TimestampPanel extends StatelessWidget {
  const TimestampPanel(
      {Key? key, required this.createdAt, required this.updatedAt})
      : super(key: key);

  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            TextComposition(
                label: "Created at:",
                content: DateParse.returnCollActionDate(
                    createdAt, DateFormatOutput.withYear),
                textCompositionSize: TextCompositionSize.small),
            const SizedBox(width: 80),
            TextComposition(
                label: "Updated at:",
                content: DateParse.returnCollActionDate(
                    updatedAt, DateFormatOutput.withYear),
                textCompositionSize: TextCompositionSize.small),
          ],
        )
      ],
    );
  }
}
