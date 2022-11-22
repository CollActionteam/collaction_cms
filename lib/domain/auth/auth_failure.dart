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

  ///email or uid not found
  const factory AuthFailure.userNotFound(
    final T error,
  ) = UserNotFound<T>;

  const factory AuthFailure.wrongPassword(
    final T error,
  ) = WrongPassword<T>;

  ///This error ocurrs when the function [signInWithEmailAndPassword] gets called
  ///and the email value is incorrect
  const factory AuthFailure.invalidEmail(
    final T error,
  ) = InvalidEmail<T>;

  const factory AuthFailure.tooManyRequests(
    final T error,
  ) = TooManyRequests<T>;

  const factory AuthFailure.incorrectRole(
    final T error,
  ) = IncorrectRole<T>;

  ///There are two ways to get this failure:
  ///
  ///The first one is when the function [sendEmailLinkAuth] gets called with
  ///incomplete information, such as a url being incomplete.
  ///
  ///The second one is when a guest admin navigates to [/verification] screen to verificate an account
  ///and the url is not valid, so there has not being made a call to generate the url provided.
  const factory AuthFailure.invalidUri(
    final T error
    ) = InvalidUri<T>;

  /// Error that handle if an empty value is returned after calling [verifyUser]
  const factory AuthFailure.emptyUid(
    final T error,
    ) = EmptyUid<T>;

  /// When a user has already set their password and calls [addPassword]
  const factory AuthFailure.passwordHasBeenSet(
    final T error
  ) = PasswordHasBeenSet<T>;
}
