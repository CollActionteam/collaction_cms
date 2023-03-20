part of 'mediator_bloc.dart';

@freezed
class MediatorEvent with _$MediatorEvent {
  const factory MediatorEvent.loadCrowdActionInfo(
    CrowdActionInfo crowdActionInfo,
  ) = _LoadCrowdActionInfo;

  const factory MediatorEvent.loadCrowdActionImages(
    CrowdActionImages crowdActionImages,
  ) = _LoadCrowdActionImages;

  const factory MediatorEvent.loadCrowdActionCommitments(
    List<Commitment> crowdActionCommitments,
  ) = _LoadCrowdActionCommitments;
}
