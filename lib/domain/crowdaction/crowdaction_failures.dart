import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_failures.freezed.dart';

@freezed
class CrowdActionFailure<T> with _$CrowdActionFailure<T> {
  const factory CrowdActionFailure.serverError(
    final T error
  ) = ServerError<T>;

  const factory CrowdActionFailure.crowdActionNotFound(
    final T error
  ) = CrowdActionNotFound<T>;

  const factory CrowdActionFailure.networkRequestFailed(
    final T error
  ) = NetworkRequestFailed<T>;
      
}