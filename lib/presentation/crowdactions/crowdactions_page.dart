import 'package:collaction_cms/application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/core/enums/enums.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/crowdaction_form_modal.dart';
import 'package:collaction_cms/presentation/crowdactions/table.dart';
import 'package:collaction_cms/presentation/shared/buttons/buttons.dart';
import 'package:collaction_cms/presentation/shared/filters/dropdown.dart';
import 'package:collaction_cms/presentation/shared/filters/search_input.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrowdActionPage extends StatefulWidget {
  const CrowdActionPage({Key? key}) : super(key: key);

  @override
  State<CrowdActionPage> createState() => _CrowdActionPageState();
}

class _CrowdActionPageState extends State<CrowdActionPage> {
  final TextEditingController _searchInputController = TextEditingController();
  final dropdownItemsSearchBy = ["Title", "Id"];
  final dropdownItemsSearchByStatus = ["All", "Waiting", "Started", "Ended"];
  String? dropdownItemSearchByValue;
  String? dropdownItemSearchByStatus;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 860,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 18),
              alignment: Alignment.centerLeft,
              child: const SelectableText(
                "CrowdActions",
                style: CollactionTextStyles.titleStyle26,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: const SelectableText("Single search",
                    style: CollactionTextStyles.bodyMedium14)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownFilter(
                  items: dropdownItemsSearchBy,
                  rectSide: RectSide.right,
                  getValueCallback: (String value) {
                    setState(() {
                      dropdownItemSearchByValue = value;
                    });
                  },
                ),
                const SizedBox(width: 10),
                SearchInput(
                  rectSide: RectSide.left,
                  searchBy:
                      dropdownItemSearchByValue ?? dropdownItemsSearchBy.first,
                  callback: () {
                    if ((dropdownItemSearchByValue ??
                            dropdownItemsSearchBy.first) ==
                        "Title") {
                      print(_searchInputController.text.runtimeType);
                      BlocProvider.of<CrowdActionGetterBloc>(context).add(
                          CrowdActionGetterEvent.fetchSingleCrowdAction(
                              null, _searchInputController.text.toLowerCase()));
                    }

                    if (dropdownItemSearchByValue == "Id") {
                      print(_searchInputController.text.runtimeType);
                      BlocProvider.of<CrowdActionGetterBloc>(context).add(
                          CrowdActionGetterEvent.fetchSingleCrowdAction(
                              _searchInputController.text.toLowerCase(), null));
                    }
                  },
                  controller: _searchInputController,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Spacer(),
                CollActionButtonRectangle.wrapped(
                  text: "Add CrowdAction",
                  onPressed: () => showCrowdActionFormModal(context, null),
                  iconData: Icons.add_circle_outline_rounded,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const SelectableText.rich(
                    TextSpan(
                      text: "Group search",
                      style: CollactionTextStyles.bodyMedium14,
                      children: <TextSpan>[
                        TextSpan(
                            text: " by status",
                            style: CollactionTextStyles.captionStyleLight)
                      ],
                    ),
                    strutStyle: StrutStyle(height: 1.4),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.only(top: 4),
                    width: 405,
                    child: const Divider(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  DropdownFilter(
                    items: dropdownItemsSearchByStatus,
                    getValueCallback: (String value) {
                      setState(() {
                        dropdownItemSearchByStatus = value;
                        print(dropdownItemSearchByStatus);
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  SearchIcon(
                      callback: () => {
                            BlocProvider.of<CrowdActionGetterBloc>(context).add(
                                CrowdActionGetterEvent.fetchCrowdActions(1, 8,
                                    Status.enumOf(dropdownItemSearchByStatus)))
                          })
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                  alignment: Alignment.topLeft, child: CrowdActionsTable()),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
