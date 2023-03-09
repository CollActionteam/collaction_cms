part of 'mediator_bloc.dart';

@freezed
class MediatorState with _$MediatorState {
  factory MediatorState.initial(
    CrowdActionFractured crowdActionFracture,
  ) = _Initial;

  const factory MediatorState.loading() = _Loading;

  factory MediatorState.loaded(
    CrowdActionFractured crowdActionFracture,
  ) = _Loaded;

  factory MediatorState.error(
    final String error,
  ) = _Error;
}
