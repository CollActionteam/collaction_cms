import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:collaction_cms/presentation/go_routing/routes.dart';
import 'package:flutter/material.dart';

class CrowdActionFormModal extends StatefulWidget {
  final CrowdAction? crowdAction;
  const CrowdActionFormModal({
    super.key,
    this.crowdAction,
  });

  @override
  State<CrowdActionFormModal> createState() => _CrowdActionFormModalState();
}

class _CrowdActionFormModalState extends State<CrowdActionFormModal> {
  late CrowdActionDto? _crowdActionDto;
  late final String modalTitle;

  @override
  void initState() {
    super.initState();
    widget.crowdAction == null ? setupForm(widget.crowdAction!) : emptyForm();
  }

  void setupForm(CrowdAction crowdAction) {
    modalTitle = "Edit CrowdAction";
  }

  void emptyForm() {
    modalTitle = "New CrowdAction";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.9,
      constraints: const BoxConstraints(
        maxHeight: 875,
        maxWidth: 1032,
      ),
      child: Column(
        children: [
          Text(
            modalTitle,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          ListView(
            children: [
              Row(
                children: [],
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<void> showCrowdActionFormModal(
    BuildContext context, CrowdAction? crowdAction) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CrowdActionFormModal(
        crowdAction: crowdAction,
      );
    },
  );
}
