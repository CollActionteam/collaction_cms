import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_creation_failures.freezed.dart';

@freezed
class CrowdActionCreationFailure<T> with _$CrowdActionCreationFailure<T> {
  const factory CrowdActionCreationFailure.serverError(final T error) =
      ServerError<T>;

  const factory CrowdActionCreationFailure.mediatorError(final T error) =
      MediatorError<T>;

  const factory CrowdActionCreationFailure.networkRequestFailed(final T error) =
      NetworkRequestFailed<T>;
}
