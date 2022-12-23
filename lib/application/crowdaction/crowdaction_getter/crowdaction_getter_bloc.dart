import 'package:bloc/bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_cms/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';

part 'crowdaction_getter_bloc.freezed.dart';
part 'crowdaction_getter_event.dart';
part 'crowdaction_getter_state.dart';

@injectable
class CrowdActionGetterBloc
    extends Bloc<CrowdActionGetterEvent, CrowdActionGetterState> {
  final ICrowdActionRepository _crowdActionRepository;

  CrowdActionGetterBloc(this._crowdActionRepository)
      : super(const CrowdActionGetterState.initial()) {
    on<CrowdActionGetterEvent>((event, emit) async {
      await event.map(
        fetchCrowdActions: (event) async {
          emit(const CrowdActionGetterState.fetchingCrowdActions());
          Either<CrowdActionFailure, List<CrowdAction>> response =
              await _crowdActionRepository.getCrowdActions(
                  event.page, event.pageSize, event.status);

          emit(response.fold(
              (failure) =>
                  CrowdActionGetterState.crowdActionsFetchError(failure),
              (crowdActions) => CrowdActionGetterState.fetched(crowdActions)));
        },
      );
    });
  }
}
