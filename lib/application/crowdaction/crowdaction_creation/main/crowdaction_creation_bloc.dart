import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/crowdaction_creation_failures.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_fracture.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/i_create_crowdation_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'crowdaction_creation_event.dart';
part 'crowdaction_creation_state.dart';
part 'crowdaction_creation_bloc.freezed.dart';

@injectable
class CrowdActionCreationBloc
    extends Bloc<CrowdActionCreationEvent, CrowdActionCreationState> {
  final MediatorBloc _mediatorBloc;
  late StreamSubscription mediatorStreamSubscription;
  final ICreateCrowdActionRepository _createCrowdActionRepository;

  CrowdActionCreationBloc(this._mediatorBloc, this._createCrowdActionRepository)
      : super(const CrowdActionCreationState.initial()) {
    mediatorStreamSubscription = _mediatorBloc.stream.listen(
      (state) {
        state.mapOrNull(
            loaded: (state) {
              if (state.crowdActionFracture.crowdActionCommitments != null &&
                  state.crowdActionFracture.crowdActionImages != null &&
                  state.crowdActionFracture.crowdActionInfo != null) {
                add(CrowdActionCreationEvent.loadCrowdActionFractured(
                    state.crowdActionFracture));
              }
            },
            error: (value) => add(CrowdActionCreationEvent.submitError(
                CrowdActionCreationFailure.mediatorError(value.error))));
      },
    );

    on<CrowdActionCreationEvent>((event, emit) async {
      await event.map(
          loadCrowdActionFractured: (event) {
            add(CrowdActionCreationEvent.createCrowdAction(
                event.crowdActionFractured));
          },
          submitError: (event) {
            emit(CrowdActionCreationState.error(
                event.crowdActionCreationFailure));
          },
          createCrowdAction: (event) => _mapCreateCrowdAction(emit, event));
    });
  }

  FutureOr<void> _mapCreateCrowdAction(
      Emitter<CrowdActionCreationState> emit, _CreateCrowdAction event) async {
    emit(const CrowdActionCreationState.loading());
    final result = await _createCrowdActionRepository.createCrowdAction(
        event.crowdActionFractured.crowdActionInfo!,
        event.crowdActionFractured.crowdActionCommitments!,
        event.crowdActionFractured.crowdActionImages!);
    result.fold(
        (failure) => emit(CrowdActionCreationState.error(failure)),
        (crowdActionId) =>
            emit(CrowdActionCreationState.crowdActionCreated(crowdActionId)));
  }
}
