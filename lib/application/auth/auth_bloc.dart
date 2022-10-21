import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_admin/domain/auth/auth_failure.dart';
import 'package:collaction_admin/domain/auth/i_auth_repository.dart';
import 'package:collaction_admin/infrastructure/authentication/firebase_auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;

  User? authedUser;
  
  late StreamSubscription<Option<User>> _authenticationSubscription;
  late StreamSubscription<AuthenticationStatus> _authenticationSubscriptionTest;

  AuthBloc(this.authRepository) : super(const AuthState.unknown()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        authCheckRequested: (event) async => await _mapAuthCheckRequested(emit, event), 
        signedOut: (event) async => await _mapSignedOut(emit, event), 
        signInWithEmailAndPassword: (event) async => await _mapSignInWithEmailAndPassword(emit, event), 
        authCheckRequestedTest: (event) async => await _mapAuthCheckRequestedTest(emit, event)
      );
    });

    _authenticationSubscription = 
        authRepository.user.listen((event) => add(const AuthEvent.authCheckRequested()));
  }

  FutureOr<void> _mapAuthCheckRequested(
    Emitter<AuthState> emit,
    _AuthCheckRequested event
    ) async {
      final userOption = await authRepository.user.first;
      emit(
        userOption.fold(
          () => const AuthState.unaunthenticated(),
          (user) {
            authedUser = user;
            return AuthState.authenticated(user);
          },
        ),
      );
  }

  FutureOr<void> _mapSignedOut(
    Emitter<AuthState> emit,
    _SignedOut event
    ) async {
      await authRepository.signOut();
      emit(const AuthState.unaunthenticated());
    }
  
  FutureOr<void> _mapSignInWithEmailAndPassword(
    Emitter<AuthState> emit,
    _SignInWithEmailAndPassword event
  ) async {
    final result = await authRepository.signInWithEmailAndPassword(
      email: event.email,
      password: event.password
    );

    result.fold(
      (failure) => emit(AuthState.authError(failure)), 
      (user) => add(const AuthEvent.authCheckRequested())
    );
  }

  FutureOr<void> _mapAuthCheckRequestedTest(
    Emitter<AuthState> emit,
    _AuthCheckRequestedTest event
  ) async {
    switch(event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthState.unaunthenticated());
      case AuthenticationStatus.authenticated:
        return emit(const AuthState.authenticated(null));
      case AuthenticationStatus.unknown:
        return emit(const AuthState.unknown());
      default:
        return emit(const AuthState.unknown());
    }
  }
}

