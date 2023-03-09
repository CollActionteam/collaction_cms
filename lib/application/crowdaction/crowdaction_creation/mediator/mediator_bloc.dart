import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_fracture.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'mediator_bloc.freezed.dart';
part 'mediator_event.dart';
part 'mediator_state.dart';

@injectable
class MediatorBloc extends Bloc<MediatorEvent, MediatorState> {
  MediatorBloc() : super(MediatorState.initial(CrowdActionFractured())) {
    on<MediatorEvent>((event, emit) async {
      await event.map(
        loadCrowdActionInfo: (event) async =>
            _mapLoadCrowdActionInfo(event, emit),
        loadCrowdActionImages: (event) async =>
            _mapLoadCrowdActionImages(event, emit),
        loadCrowdActionCommitments: (event) async =>
            _mapLoadCrowdActionCommitments(event, emit),
      );
    });
  }

  FutureOr<void> _mapLoadCrowdActionInfo(
      _LoadCrowdActionInfo event, Emitter<MediatorState> emit) async {
    try {
      emit(MediatorState.loaded(CrowdActionFractured()
          .copyWith(crowdActionInfo: event.crowdActionInfo)));
    } catch (e) {
      emit(MediatorState.error(e.toString()));
    }
  }

  FutureOr<void> _mapLoadCrowdActionImages(
      _LoadCrowdActionImages event, Emitter<MediatorState> emit) async {
    try {
      CrowdActionFractured? crowdActionFracturedInitial;
      state.mapOrNull(
        loaded: (value) =>
            crowdActionFracturedInitial = value.crowdActionFracture,
      );
      emit(MediatorState.loaded(crowdActionFracturedInitial!
          .copyWith(crowdActionImages: event.crowdActionImages)));
    } catch (e) {
      emit(MediatorState.error(e.toString()));
    }
  }

  FutureOr<void> _mapLoadCrowdActionCommitments(
      _LoadCrowdActionCommitments event, Emitter<MediatorState> emit) async {
    try {
      CrowdActionFractured? crowdActionFracturedInitial;
      state.mapOrNull(
        loaded: (value) =>
            crowdActionFracturedInitial = value.crowdActionFracture,
      );
      emit(MediatorState.loaded(crowdActionFracturedInitial!
          .copyWith(crowdActionCommitments: event.crowdActionCommitments)));
    } catch (e) {
      emit(MediatorState.error(e.toString()));
    }
  }
}
