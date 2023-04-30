part of 'crowdaction_creation_bloc.dart';

@freezed
class CrowdActionCreationEvent with _$CrowdActionCreationEvent {
  const factory CrowdActionCreationEvent.createCrowdAction(
    CrowdActionInfo crowdActionInfo,
    List<Commitment> commitments,
    CrowdActionImages crowdActionImages,
  ) = _CreateCrowdAction;

  const factory CrowdActionCreationEvent.submitError(
    CrowdActionCreationFailure crowdActionCreationFailure,
  ) = _SubmitError;
}
