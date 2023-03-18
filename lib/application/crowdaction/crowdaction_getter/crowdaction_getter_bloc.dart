import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/crowdaction_failures.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';
import '../../../domain/crowdaction/pagination/paginated_crowdactions.dart';
import '../pagination/pagination_cubit.dart';

part 'crowdaction_getter_bloc.freezed.dart';
part 'crowdaction_getter_event.dart';
part 'crowdaction_getter_state.dart';

@injectable
class CrowdActionGetterBloc
    extends Bloc<CrowdActionGetterEvent, CrowdActionGetterState> {
  final ICrowdActionRepository _crowdActionRepository;
  final PaginationCubit _paginationCubit;

  CrowdActionGetterBloc(this._crowdActionRepository, this._paginationCubit)
      : super(const CrowdActionGetterState.initial()) {
    on<CrowdActionGetterEvent>((event, emit) async {
      await event.map(
        fetchCrowdActions: (event) async {
          emit(const CrowdActionGetterState.fetchingCrowdActions());

          final response = await _crowdActionRepository.getCrowdActions(
            event.page,
            event.pageSize,
            event.status != null ? event.status!.value : null,
          );

          response.fold(
            (failure) => emit(
              CrowdActionGetterState.crowdActionsFetchError(failure),
            ),
            (paginatedCrowdActions) {
              _paginationCubit.emit(
                PaginationLoaded(
                  page: paginatedCrowdActions.paginationInfo.page,
                  totalPages: paginatedCrowdActions.paginationInfo.totalPages,
                  status: event.status,
                  pageSize: event.pageSize,
                ),
              );

              emit(CrowdActionGetterState.fetched(paginatedCrowdActions));
            },
          );
        },
        fetchSingleCrowdAction: (event) async =>
            await _mapFetchSingleCrowdAction(emit, event),
      );
    });
  }

  FutureOr<void> _mapFetchSingleCrowdAction(
    Emitter<CrowdActionGetterState> emit,
    _FetchSingleCrowdAction event,
  ) async {
    emit(const CrowdActionGetterState.fetchingCrowdActions());

    // Because empty strings are causing a different error response from the api, we are converting the
    // the emtpty strings to a space.
    final slug = _spaceOrValue(event.slug);
    final id = _spaceOrValue(event.id);

    final result = await _crowdActionRepository.getCrowdAction(slug, id);

    result.fold(
      (failure) => emit(CrowdActionGetterState.crowdActionsFetchError(failure)),
      (crowdActions) => emit(CrowdActionGetterState.fetched(crowdActions)),
    );
  }

  String _spaceOrValue(String? value) =>
      value == null || value.isEmpty ? " " : value;
}
