part of 'crowdaction_getter_bloc.dart';

@freezed
class CrowdActionGetterState with _$CrowdActionGetterState {
  const factory CrowdActionGetterState.initial() = _Initial;

  const factory CrowdActionGetterState.fetchingCrowdActions() =
      _FetchingCrowdActions;

  const factory CrowdActionGetterState.fetched(PaginatedCrowdActions paginatedCrowdActions) =
      _Fetched;

  const factory CrowdActionGetterState.crowdActionsFetchError(
    CrowdActionFailure crowdActionFailure
  ) = _CrowdActionsFetchError;
}
