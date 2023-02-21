part of 'crowdaction_view_info_cubit.dart';

@freezed
class CrowdActionViewInfoState with _$CrowdActionViewInfoState {
  const factory CrowdActionViewInfoState.info() = _Info;
  const factory CrowdActionViewInfoState.dates() = _Dates;
  const factory CrowdActionViewInfoState.timestamps() = _Timestamps;
  const factory CrowdActionViewInfoState.images() = _Images;
}
