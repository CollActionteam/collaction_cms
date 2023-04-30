import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/crowdaction_creation_failures.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/i_create_crowdation_repository.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'crowdaction_creation_event.dart';
part 'crowdaction_creation_state.dart';
part 'crowdaction_creation_bloc.freezed.dart';

@injectable
class CrowdActionCreationBloc
    extends Bloc<CrowdActionCreationEvent, CrowdActionCreationState> {
  final ICreateCrowdActionRepository _createCrowdActionRepository;

  CrowdActionCreationBloc(this._createCrowdActionRepository)
      : super(const CrowdActionCreationState.initial()) {
    on<CrowdActionCreationEvent>((event, emit) async {
      await event.map(
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
        event.crowdActionInfo, event.commitments, event.crowdActionImages);
    result.fold(
        (failure) => emit(CrowdActionCreationState.error(failure)),
        (crowdActionId) =>
            emit(CrowdActionCreationState.crowdActionCreated(crowdActionId)));
  }
}
