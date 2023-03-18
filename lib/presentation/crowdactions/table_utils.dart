import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../application/crowdaction/crowdaction_selected/crowdaction_selected_cubit.dart';
import '../../application/navigation/navigation_bloc.dart';
import '../../domain/crowdaction/crowdaction.dart';
import '../../infrastructure/core/injection.dart';
import '../core/enums/enums.dart';
import '../shared/tags/status.dart';
import '../shared/utils/data_parse/date.dart';
import '../theme/constants.dart';
import 'double_text_cell.dart';

class TableUtils {
  /// Transform the crowdAction data to a row for the [DataTable]
  static DataRow dataRowProcessor(
    CrowdAction crowdAction,
    BuildContext context,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DoubleTextCell(
              highlightedText: crowdAction.title,
              regularText: crowdAction.id,
              isItHyperlink: true,
              callback: () {
                getIt<CrowdActionSelectedCubit>()
                    .loadCrowdActionSelected(crowdAction);

                BlocProvider.of<NavigationBloc>(context).add(
                  NavigateToPageEvent(
                    route: '/cms/crowdaction',
                  ),
                );
              },
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DoubleTextCell(
              highlightedText: crowdAction.category,
              regularText: crowdAction.subcategory ?? "--",
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            height: double.infinity,
            child: SelectableText(
              crowdAction.location.code,
              style: CollactionTextStyles.bodyMedium14,
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DoubleTextCell(
              highlightedText: DateParse.returnCollActionDate(
                  crowdAction.createdAt, DateFormatOutput.withoutYear),
              regularText: crowdAction.createdAt.year.toString(),
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DoubleTextCell(
              highlightedText: DateParse.returnCollActionDate(
                  crowdAction.endAt, DateFormatOutput.withoutYear),
              regularText: crowdAction.endAt.year.toString(),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            height: double.infinity,
            child: StatusTag(status: crowdAction.status),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            height: double.infinity,
            child: SelectableText(
              "${crowdAction.participantCount}",
              style: CollactionTextStyles.body14,
            ),
          ),
        )
      ],
    );
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
