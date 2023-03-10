part of 'crowdaction_creation_bloc.dart';

@freezed
class CrowdActionCreationState with _$CrowdActionCreationState {
  const factory CrowdActionCreationState.initial() = _Initial;
  const factory CrowdActionCreationState.loading() = _Loading;

  /// Should be [CrowdAction] not [CrowdActionFractured] It's just for testing purposes,
  /// Untill the repos are done
  const factory CrowdActionCreationState.crowdActionCreated(
    final CrowdActionFractured crowdActionFractured,
  ) = _CrowdActionCreated;

  const factory CrowdActionCreationState.error(
    CrowdActionCreationFailure crowdActionFailure,
  ) = _Error;
}
