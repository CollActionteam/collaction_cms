import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.serverError() = ServerError;

  const factory AuthFailure.networkRequestFailed() = NetworkRequestFailed;

  const factory AuthFailure.verificationFailed() = VerificationFailed;

  const factory AuthFailure.userNotFound() = UserNotFound;

  const factory AuthFailure.wrongPassword() = WrongPassword;

  const factory AuthFailure.invalidEmail() = InvalidEmail;

  const factory AuthFailure.incorrectRole() = IncorrectRole;
}
