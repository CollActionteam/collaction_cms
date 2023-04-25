import 'dart:async';
import 'dart:math' as Math;

import 'package:bloc/bloc.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/crowdaction_creation_failures.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_fracture.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'commitments_event.dart';
part 'commitments_state.dart';
part 'commitments_bloc.freezed.dart';

@injectable
class CommitmentsBloc extends Bloc<CommitmentsEvent, CommitmentsState> {
  CommitmentsBloc() : super(const CommitmentsState.initial(<Commitment>[])) {
    on<CommitmentsEvent>((event, emit) {
      event.map(
          addCommitment: (event) => _mapAddCommitment(emit, event),
          removeCommitment: (event) => _mapRemoveCommitment(emit, event),
          editCommitment: (event) => _mapEditCommitment(emit, event));
    });
  }

  FutureOr<void> _mapAddCommitment(
      Emitter<CommitmentsState> emit, _AddCommitment event) {
    List<Commitment> commitmentsOld = [];

    state.mapOrNull(
        commitmentsSet: (state) => commitmentsOld = state.commitments);

    emit(
        CommitmentsState.commitmentsSet([...commitmentsOld, event.commitment]));
  }

  FutureOr<void> _mapRemoveCommitment(
      Emitter<CommitmentsState> emit, _RemoveCommitment event) {
    List<Commitment> commitmentsOld = [];

    state.mapOrNull(
      commitmentsSet: (state) => commitmentsOld = state.commitments,
    );

    List<Commitment> commitmentsNew =
        commitmentsOld.where((element) => element.id != event.id).toList();
    emit(CommitmentsState.commitmentsSet(commitmentsNew));
  }

  FutureOr<void> _mapEditCommitment(
      Emitter<CommitmentsState> emit, _EditCommitment event) {
    List<Commitment> commitmentOld = [];

    state.mapOrNull(
        commitmentsSet: (state) => commitmentOld = state.commitments);

    List<Commitment> commitmentsNew = commitmentOld.map((commitment) {
      if (commitment.id == event.commitment.id) {
        return event.commitment.copyWith(id: commitment.id);
      } else {
        return commitment;
      }
    }).toList();
    emit(CommitmentsState.commitmentsSet([...commitmentsNew]));
  }
}
