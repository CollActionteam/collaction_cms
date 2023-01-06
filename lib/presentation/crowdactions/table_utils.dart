import 'package:collaction_cms/application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/core/enums/enums.dart';
import 'package:collaction_cms/presentation/crowdactions/double_text_cell.dart';
import 'package:collaction_cms/presentation/shared/tags/status.dart';
import 'package:collaction_cms/presentation/shared/utils/data_parse/date.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableUtils {
  /// Transform the crowdAction data to a row for the [DataTable]
  static DataRow dataRowProcessor(CrowdAction crowdAction) {
    return DataRow(cells: <DataCell>[
      DataCell(Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: DoubleTextCell(
          highlightedText: crowdAction.title,
          regularText: crowdAction.id,
          isItHyperlink: true,
          callback: () => {},
        ),
      )),
      DataCell(Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: DoubleTextCell(
            highlightedText: crowdAction.category,
            regularText: crowdAction.subcategory!,
          ))),
      DataCell(Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          height: double.infinity,
          child: SelectableText(
            crowdAction.location.code,
            style: CollactionTextStyles.bodyMedium14,
          ))),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: DoubleTextCell(
          highlightedText:
              DateParse.returnCollActionDate(crowdAction.createdAt),
          regularText: crowdAction.createdAt.year.toString(),
        ),
      )),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: DoubleTextCell(
            highlightedText: DateParse.returnCollActionDate(crowdAction.endAt),
            regularText: crowdAction.endAt.year.toString(),
          ),
        ),
      ),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        height: double.infinity,
        child: StatusTag(status: crowdAction.status),
      )),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        height: double.infinity,
        child: SelectableText(
          "${crowdAction.participantCount}",
          style: CollactionTextStyles.body14,
        ),
      ))
    ]);
  }

  ///Some logis is needed before sending the callback to pagination buttons
  ///
  ///[typeOfPaginationTrigger] could be "previous" and "next"
  static Function paginationLogic(
      PaginationButtonType paginationButtonType,
      BuildContext context,
      int page,
      int totalPages,
      Status? status,
      int pageSize) {

    if (1 == totalPages) {
      return () => {};
    }

    if (paginationButtonType == PaginationButtonType.previous) {
      if (page > 1) {
        return () => {
              BlocProvider.of<CrowdActionGetterBloc>(context).add(
                  CrowdActionGetterEvent.fetchCrowdActions(
                      page - 1, pageSize, status))
            };
      }
      return () => {};
    }

    if (paginationButtonType == PaginationButtonType.next) {
      if (page < totalPages) {
        return () => {
              BlocProvider.of<CrowdActionGetterBloc>(context).add(
                  CrowdActionGetterEvent.fetchCrowdActions(
                      page + 1, pageSize, status))
            };
      }

      return () => {};
    }

    return () => {};
  }
}
