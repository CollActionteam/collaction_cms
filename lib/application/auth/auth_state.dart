part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {

  const factory AuthState.authInitial() = _AuthInitial;

  const factory AuthState.unaunthenticated() = _Unauthenticated;

  const factory AuthState.authError(AuthFailure failure) = _AuthError;

  const factory AuthState.signingInUser() = _SigningInUser;

  const factory AuthState.authenticated(
    final User? user
  ) = _Authenticated;

  const factory AuthState.preAuthenticated(
    final User? user
  ) = _PreAuthenticated;

  const factory AuthState.unknown() = _Unknown;
}

