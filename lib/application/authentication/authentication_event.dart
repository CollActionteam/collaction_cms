part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthCheckRequested extends AuthenticationEvent {}

class SignedOut extends AuthenticationEvent {}

class SignInWithEmailAndPassword extends AuthenticationEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword(this.email, this.password);
}
