part of 'crowdaction_creation_bloc.dart';

@freezed
class CrowdActionCreationState with _$CrowdActionCreationState {
  const factory CrowdActionCreationState.initial() = _Initial;
  const factory CrowdActionCreationState.loading() = _Loading;

  const factory CrowdActionCreationState.crowdActionCreated(
    final String crowdActionId,
  ) = _CrowdActionCreated;

  const factory CrowdActionCreationState.error(
    CrowdActionCreationFailure crowdActionFailure,
  ) = _Error;
}
