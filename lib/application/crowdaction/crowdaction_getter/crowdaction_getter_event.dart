part of 'crowdaction_getter_bloc.dart';

@freezed
class CrowdActionGetterEvent with _$CrowdActionGetterEvent {
  const factory CrowdActionGetterEvent.fetchCrowdActions(
    int page,
    int pageSize,
    Status? status
  ) = _FetchCrowdActions;
}