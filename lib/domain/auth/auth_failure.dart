import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure<T> with _$AuthFailure<T> {
  const factory AuthFailure.serverError(
    final T error,
  ) = ServerError<T>;

  const factory AuthFailure.networkRequestFailed(
    final T error,
  ) = NetworkRequestFailed<T>;

  const factory AuthFailure.verificationFailed(
    final T error,
  ) = VerificationFailed<T>;

  const factory AuthFailure.userNotFound(
    final T error,
  ) = UserNotFound<T>;

  const factory AuthFailure.wrongPassword(
    final T error,
  ) = WrongPassword<T>;

  const factory AuthFailure.invalidEmail(
    final T error,
  ) = InvalidEmail<T>;

  const factory AuthFailure.incorrectRole(
    final T error,
  ) = IncorrectRole<T>;
}
