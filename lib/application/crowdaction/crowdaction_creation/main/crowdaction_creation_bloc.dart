import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/crowdaction_creation_failures.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_fracture.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_creation_event.dart';
part 'crowdaction_creation_state.dart';
part 'crowdaction_creation_bloc.freezed.dart';

class CrowdActionCreationBloc
    extends Bloc<CrowdActionCreationEvent, CrowdActionCreationState> {
  final MediatorBloc _mediatorBloc;
  late StreamSubscription mediatorStreamSubscription;

  CrowdActionCreationBloc(this._mediatorBloc)
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

  //Implement repositories
  FutureOr<void> _mapCreateCrowdAction(
      Emitter<CrowdActionCreationState> emit, _CreateCrowdAction event) {
    emit(CrowdActionCreationState.crowdActionCreated(
        event.crowdActionFractured));
  }
}
