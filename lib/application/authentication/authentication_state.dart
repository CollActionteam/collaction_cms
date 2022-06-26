part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {
  final String? error;

  Unauthenticated({this.error});
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);
}
