part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  ///[AuthEvent.authCheckRequested] event check if a [User] is being returned by
  ///the [FirebaseAuth.instance] and emits [AuthState.authenticated]. But, the [User] needs to
  ///meet the following conditions:
  ///
  ///The user must have [role.ADMIN] set in firebase custom claims
  ///
  ///Also the IdProvider must be "password".This indicates that the user already have set their password.
  ///
  ///If a [User] not meet the conditions above, [AuthState.unaunthenticated] is emitted
  const factory AuthEvent.authCheckRequested() = _AuthCheckRequested;

  const factory AuthEvent.signedOut() = _SignedOut;

  ///Regular sign in transition event. When a user submit the [/log-in] form
  ///this state gets triggered
  const factory AuthEvent.signInWithEmailAndPassword(
      final String email, final String password) = _SignInWithEmailAndPassword;

  ///This event gets triggered when a user clicks an invitation link(external link navigation)
  ///or changes the browser url to [/verification] manually.
  ///
  /// The reason behind this event is that, instead of just triggering a navigation event,
  ///a special handler is needed because if you set up the url manually the app gets restarted,
  ///this is the default behavior of [UrlPathStrategy.path]. So you need to avoid calling
  ///[AuthEvent.authCheckRequested] initially and instead navigate to [/verification] screen.
  const factory AuthEvent.toVerification(
      final String href, final String pathname) = _ToVerification;

  ///This event gets triggered when a user submit the email verification form on the [/verification] screen
  ///to verify their user email after received an email invitation link.
  const factory AuthEvent.verifyUser(final String email, final String url) =
      _VerifyUser;

  ///This event gets triggered when the user submit the invitation form
  ///on the invitation modal.
  const factory AuthEvent.sendSignInLinkToEmail(
    final String email,
    final ActionCodeSettings actionCodeSettings,
  ) = _SendSignInLinkToEmail;

  ///After the user verifies their account successfully, it navigates to
  ///[create_credentials] screen to set up a password. When the user submit the
  ///password form this event gets triggered.
  const factory AuthEvent.addPassword(final String uid, final String password) =
      _AddPassword;
}
