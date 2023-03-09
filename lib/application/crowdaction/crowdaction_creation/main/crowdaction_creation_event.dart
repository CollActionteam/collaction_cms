part of 'crowdaction_creation_bloc.dart';

@freezed
class CrowdActionCreationEvent with _$CrowdActionCreationEvent {
  const factory CrowdActionCreationEvent.loadCrowdActionFractured(
    CrowdActionFractured crowdActionFractured,
  ) = _LoadCrowdActionFractured;

  const factory CrowdActionCreationEvent.submitError(
    CrowdActionCreationFailure crowdActionCreationFailure,
  ) = _SubmitError;

  const factory CrowdActionCreationEvent.createCrowdAction(
    CrowdActionFractured crowdActionFractured,
  ) = _CreateCrowdAction;
}
