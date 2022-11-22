part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  ///Initial state
  const factory AuthState.unknown() = _Unknown;

  ///Check [AuthEvent.authCheckRequested]
  const factory AuthState.unaunthenticated() = _Unauthenticated;

  ///Check [AuthEvent.authCheckRequested]
  const factory AuthState.authenticated(final User? user) = _Authenticated;

  const factory AuthState.authError(AuthFailure failure) = _AuthError;

  ///Regular sign in transition state. When a user submit the [/log-in] form
  ///this state gets emitted
  const factory AuthState.signingInUser() = _SigningInUser;

  ///State when the user is on [/verification] screen. [AuthEvent.toVerification] emits
  ///this state.
  const factory AuthState.onVerification(
    final String? href,
    final String? pathname,
  ) = _OnVerification;

  ///Transitiory state when the user submit the form to verify their email
  ///on [/verification] screen
  const factory AuthState.verifyingUser() = _VerifyingUser;

  ///When a user verify their email successfully on [/verification] screen,
  ///bloc emits this state.
  const factory AuthState.preAuthenticated(final User? user) =
      _PreAuthenticated;

  ///Transitiory state when the user submit the invitation form
  ///on invitation modal.
  const factory AuthState.invitingAdmin() = _InvitingAdmin;

  ///If the invitation is successful this state is emitted
  const factory AuthState.inviteAdminDone() = _InviteAdminDone;

  ///After the user verifies their account successfully, it navigates to
  ///[create_credentials] screen to set up a password. When the user submit the
  ///password form this transition state gets emitted.
  const factory AuthState.addingPassword() = _AddingPassword;

  ///If the password set up is successful, this is the end state for the verification
  ///process.
  const factory AuthState.adminCreationCompleted() = _AdminCreationCompleted;
}
