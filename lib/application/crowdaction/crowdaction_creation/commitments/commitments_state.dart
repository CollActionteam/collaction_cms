part of 'commitments_bloc.dart';

@freezed
class CommitmentsState with _$CommitmentsState {
  const factory CommitmentsState.initial(
    List<Commitment> commitments,
  ) = _Initial;
  const factory CommitmentsState.commitmentsSet(
    List<Commitment> commitments,
  ) = _CommitmentsSet;
}
