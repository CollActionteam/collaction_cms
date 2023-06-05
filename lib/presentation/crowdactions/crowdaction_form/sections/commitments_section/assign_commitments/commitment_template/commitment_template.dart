import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/commitment_list_pages.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/tag_search.dart';
import 'package:flutter/material.dart';

class CommitmentTemplate extends StatefulWidget {
  final double fullWidth;
  const CommitmentTemplate({super.key, required this.fullWidth});

  @override
  State<CommitmentTemplate> createState() => _CommitmentTemplateState();
}

class _CommitmentTemplateState extends State<CommitmentTemplate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TagSearchSection(),
        const Divider(),
        CommitmentListPages(fullWidth: widget.fullWidth),
      ]),
    );
  }
}
