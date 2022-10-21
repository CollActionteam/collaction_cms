part of 'auth_bloc.dart';


@freezed
class AuthEvent with _$AuthEvent {

  const factory AuthEvent.authCheckRequested() = _AuthCheckRequested;

  const factory AuthEvent.signedOut() = _SignedOut;

  const factory AuthEvent.signInWithEmailAndPassword(
    final String email,
    final String password
   ) = _SignInWithEmailAndPassword;

  const factory AuthEvent.authCheckRequestedTest(
    final AuthenticationStatus status
  ) = _AuthCheckRequestedTest;
}