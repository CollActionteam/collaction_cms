import 'package:collaction_cms/application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import 'package:collaction_cms/application/crowdaction/pagination/pagination_cubit.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/core/enums/enums.dart';
import 'package:collaction_cms/presentation/crowdactions/pagination.dart';
import 'package:collaction_cms/presentation/crowdactions/table_utils.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrowdActionsTable extends StatefulWidget {
  CrowdActionsTable({Key? key}) : super(key: key);

  @override
  State<CrowdActionsTable> createState() => _CrowdActionsTableState();
}

class _CrowdActionsTableState extends State<CrowdActionsTable> {
  final List<String> _headerColumns = [
    "Title/ID",
    "Category/Sub",
    "Country",
    "Creation Date",
    "End Date",
    "Status",
    "Participants"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: BlocBuilder<CrowdActionGetterBloc, CrowdActionGetterState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    width: double.infinity,
                    child: state.mapOrNull(
                      initial: (value) {
                        return DataTableBaseWithoutData(
                            widget: const CircularProgressIndicator(
                              color: kAccentColor,
                            ),
                            headerColumns: _headerColumns);
                      },
                      fetchingCrowdActions: (value) {
                        return DataTableBaseWithoutData(
                            widget: const CircularProgressIndicator(
                              color: kAccentColor,
                            ),
                            headerColumns: _headerColumns);
                      },
                      crowdActionsFetchError: (value) {
                        late String errorMessage;
                        value.crowdActionFailure.mapOrNull(
                          serverError: (value) =>
                              errorMessage = value.error.toString(),
                          crowdActionNotFound: (value) =>
                              errorMessage = value.error.toString(),
                          networkRequestFailed: (value) =>
                              errorMessage = value.error.toString(),
                        );
                        return DataTableBaseWithoutData(
                            widget: SelectableText(
                              errorMessage,
                              style: CollactionTextStyles.bodyMedium14,
                            ),
                            headerColumns: _headerColumns);
                      },
                      fetched: (value) {
                        return DataTable(
                          showBottomBorder: false,
                          dataRowHeight: 65,
                          horizontalMargin: 0,
                          columnSpacing: 30,
                          columns: _headerColumns.map((String columnHeader) {
                            if (columnHeader == "Participants") {
                              return const DataColumn(
                                  label: Icon(
                                Icons.people,
                                color: kBlackPrimary300,
                              ));
                            } else {
                              return DataColumn(
                                  label: Container(
                                child: SelectableText(columnHeader,
                                    style: CollactionTextStyles.bodySemiBold),
                              ));
                            }
                          }).toList(),
                          rows: value.paginatedCrowdActions.crowdActions
                              .map((CrowdAction crowdAction) {
                            return TableUtils.dataRowProcessor(crowdAction, context);
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<PaginationCubit, PaginationState>(
                  builder:
                      (BuildContext cubitContext, PaginationState cubitState) {
                    if (cubitState is Unknown) {
                      return Pagination(
                          paginationInfo: "Loading Pagination",
                          callbackNext: () => {},
                          callbackPrevious: () => {});
                    } else {
                      return Pagination(
                          paginationInfo:
                              "Page ${(cubitState as PaginationLoaded).page} of ${cubitState.totalPages}",
                          callbackNext: TableUtils.paginationLogic(
                              PaginationButtonType.next,
                              context,
                              cubitState.page,
                              cubitState.totalPages,
                              cubitState.status,
                              cubitState.pageSize),
                          callbackPrevious: TableUtils.paginationLogic(
                              PaginationButtonType.previous,
                              context,
                              cubitState.page,
                              cubitState.totalPages,
                              cubitState.status,
                              cubitState.pageSize));
                    }
                  },
                )
              ],
            );
          },
        ));
  }
}

///Base for [DataTable] when is not displaying data, like
///displaying [CircularProgressIndicator]  or an error message
///
///widget property is the widget to display instead of the Data
///Can be a [CircularProgressIndicator] or a [SelectableText]
class DataTableBaseWithoutData extends StatelessWidget {
  DataTableBaseWithoutData(
      {Key? key, required this.widget, required this.headerColumns})
      : super(key: key);

  final Widget widget;
  final List<String> headerColumns;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        const SizedBox(height: double.infinity, width: double.infinity),
        DataTable(
            horizontalMargin: 0,
            columnSpacing: 63.8,
            columns: headerColumns.map((String columnHeader) {
              if (columnHeader == "Participants") {
                return DataColumn(
                    label: Container(
                  child: const Icon(
                    Icons.people,
                    color: kBlackPrimary300,
                  ),
                ));
              } else {
                return DataColumn(
                    label: Container(
                  child: SelectableText(columnHeader,
                      style: CollactionTextStyles.bodySemiBold),
                ));
              }
            }).toList(),
            rows: const [
              DataRow(cells: [
                DataCell(SizedBox(width: 188)),
                DataCell(SizedBox(width: 112)),
                DataCell(SizedBox(width: 21)),
                DataCell(SizedBox(width: 108)),
                DataCell(SizedBox(width: 104)),
                DataCell(SizedBox(width: 70)),
                DataCell(SizedBox(width: 12))
              ])
            ]),
        Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: widget)
      ],
    );
  }
}
