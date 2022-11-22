part of 'auth_bloc.dart';


@freezed
class AuthEvent with _$AuthEvent {

  const factory AuthEvent.authCheckRequested() = _AuthCheckRequested;

  const factory AuthEvent.signedOut() = _SignedOut;

  const factory AuthEvent.signInWithEmailAndPassword(
    final String email,
    final String password
   ) = _SignInWithEmailAndPassword;

  ///This event triggers the navigation flow to [/verification] screen.
  ///It's called when a user clicks an invitation link(external link navigation) or changes the browser url
  ///to [/verification].
   const factory AuthEvent.toVerification(
    final String href,
    final String pathname
   ) = _ToVerification;

  ///This event gets triggered when a user submit the email verification form on the [/verification] screen
  ///to verify their user email after received an email invitation link.
   const factory AuthEvent.verifyUser(
    final String email,
    final String url
   ) = _VerifyUser;

   const factory AuthEvent.sendSignInLinkToEmail(
    final String email,
    final ActionCodeSettings actionCodeSettings,
   ) = _SendSignInLinkToEmail;

   const factory AuthEvent.addPassword(
    final String uid,
    final String password
   ) = _AddPassword;
}