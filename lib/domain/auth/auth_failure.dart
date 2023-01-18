
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

  ///There are two ways to get this error:
  ///
  ///The first one is when the function [sendEmailLinkAuth] gets called with
  ///incomplete information, such as an incomplete url.
  ///
  ///The second one is when a guest admin navigates to [/verification] screen to verify an account
  ///and the url is not valid, so there's not an available url invitation link.
  ///The user has not being invited.
  const factory AuthFailure.invalidUri(
    final T error
    ) = InvalidUri<T>;

  /// This error ocurrs if an empty value is returned from the backend 
  const factory AuthFailure.missingValues(
    final T error,
    ) = MissingValues<T>;

  /// When a user has already set their password and calls [addPassword]
  const factory AuthFailure.passwordHasBeenSet(
    final T error
  ) = PasswordHasBeenSet<T>;
}
