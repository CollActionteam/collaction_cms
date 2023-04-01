part of 'commitments_bloc.dart';

@freezed
class CommitmentsEvent with _$CommitmentsEvent {
  const factory CommitmentsEvent.addCommitment(
    Commitment commitment,
  ) = _AddCommitment;
  const factory CommitmentsEvent.removeCommitment(
    String id,
  ) = _RemoveCommitment;
  const factory CommitmentsEvent.editCommitment(
    Commitment commitment,
  ) = _EditCommitment;
}
