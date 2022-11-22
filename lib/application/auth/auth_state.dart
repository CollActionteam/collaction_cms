part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {

  ///Initial state
  const factory AuthState.unknown() = _Unknown;

  const factory AuthState.unaunthenticated() = _Unauthenticated;

  ///[AuthCheckRequested] event check if there a user is being returned by
  ///the [FirebaseAuth.instance]. If there is a [User] that meets the following conditions:
  ///The user must an have a [role.ADMIN] set in firebase custom claims
  ///Also the IdProvider must be "password".This indicates that the user already have set their password
  const factory AuthState.authenticated(
    final User? user
  ) = _Authenticated;

  const factory AuthState.authError(AuthFailure failure) = _AuthError;

  const factory AuthState.signingInUser() = _SigningInUser;
  
  ///State when the user is on [/verification] screen
  const factory AuthState.onVerification(
    final String? href,
    final String? pathname,
  ) = _OnVerification;

  ///Transitiory state when the user submit the form to verify their email 
  ///on [/verification] screen
  const factory AuthState.verifyingUser() = _VerifyingUser;

  ///When a user verify their email succesfully on [/verification] screen, 
  ///bloc emits this state.
  const factory AuthState.preAuthenticated(
    final User? user
  ) = _PreAuthenticated;

  ///Transitiory state when the user submit the invitation form
  ///on invitation modal. 
  const factory AuthState.invitingAdmin() = _InvitingAdmin;

  ///If the invitation is succesful this state is emmited
  const factory AuthState.inviteAdminDone() = _InviteAdminDone;

  ///After the user verifies their account succesfully navigates to 
  ///[create_credentials] screen to set up a password. When the user submit the 
  ///password form this transition state gets triggered.
  const factory AuthState.addingPassword() = _AddingPassword;

  ///If the password set up is succesful, this is the end state.
  const factory AuthState.adminCreationCompleted() = _AdminCreationCompleted;

}
