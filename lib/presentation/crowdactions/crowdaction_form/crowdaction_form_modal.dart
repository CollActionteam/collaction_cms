import 'package:collaction_cms/application/crowdaction/crowdaction_creation/commitments/commitments_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/commitments_form.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/crowdaction_info/crowdaction_info_form.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/crowdaction_info/crowdaction_info_controller.dart';
import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_canvas/tap_canvas.dart';
import 'package:collaction_cms/infrastructure/core/injection.dart';

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
  late final String modalTitle;
  bool _buttonTriggered = false;
  final CrowdActionInfoFormController _crowdActionInfoFormController =
      CrowdActionInfoFormController();

  @override
  void initState() {
    super.initState();
    widget.crowdAction != null ? setupForm(widget.crowdAction) : emptyForm();
  }

  void setupForm(CrowdAction? crowdAction) {
    modalTitle = "Edit CrowdAction";
  }

  void emptyForm() {
    modalTitle = "New CrowdAction";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CommitmentsBloc>(),
      child: SizedBox(
        width: 1032,
        height: 875,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 74,
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF8B8B8B),
                      width: 0.25,
                    ),
                  ),
                ),
                child: Text(
                  modalTitle,
                  style: CollactionTextStyles.titleStyle,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: DeferredPointerHandler(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              double halfWidth = constraints.maxWidth < 640
                                  ? double.infinity
                                  : constraints.maxWidth * 0.5 - 5;
                              double halfWidthCommitments =
                                  constraints.maxWidth < 760
                                      ? double.infinity
                                      : constraints.maxWidth * 0.5 - 5;
                              return Wrap(
                                spacing: 10,
                                children: [
                                  CrowdActionInfoForm(
                                    width: halfWidth,
                                    buttonTriggered: _buttonTriggered,
                                    controller: _crowdActionInfoFormController,
                                  ),
                                  // replace with CrowdActionImagesForm
                                  CrowdActionInfoForm(
                                    width: halfWidth,
                                    buttonTriggered: _buttonTriggered,
                                    controller: _crowdActionInfoFormController,
                                  ),
                                  CrowdActionCommitmentsForm(
                                    width: halfWidthCommitments,
                                    buttonTriggered: _buttonTriggered,
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 88,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF8B8B8B),
                      width: 0.25,
                    ),
                  ),
                ),
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    CollActionButtonRectangle.wrapped(
                      text: "Save CrowdAction",
                      onPressed: () => setState(() {
                        _buttonTriggered = true;
                      }),
                      width: 157,
                      height: 37,
                      padding: 0,
                    ),
                    CollActionButtonRectangle.wrapped(
                      text: "Cancel",
                      onPressed: () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop('dialog'),
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
    );
  }
}

void showCrowdActionFormModal(
    BuildContext context, CrowdAction? crowdAction) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return TapCanvas(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: CrowdActionFormModal(
            crowdAction: crowdAction,
          ),
        ),
      );
    },
  );
}
