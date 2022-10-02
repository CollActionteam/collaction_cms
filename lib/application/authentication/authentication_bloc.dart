import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_admin/domain/authentication/i_auth_repository.dart';
import 'package:collaction_admin/infrastructure/authentication/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthRepository authRepository;
  User? authedUser;
  late StreamSubscription<Option<User>> _authenticationSubscription;
  late StreamSubscription<AuthenticationStatus> _authenticationSubscriptionTest;

  AuthenticationBloc(this.authRepository) : super(Unknown()) {
    on<AuthCheckRequested>((event, emit) async {
      final userOption = await authRepository.user.first;
      emit(
        userOption.fold(
          () => Unauthenticated(),
          (user) {
            authedUser = user;
            return Authenticated(user);
          },
        ),
      );
    });

    on<SignedOut>((event, emit) async {
      await authRepository.signOut();
      emit(Unauthenticated());
    });

    on<SignInWithEmailAndPassword>((event, emit) async {
      final result = await authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failure) => emit(Unauthenticated()),
        (user) => add(AuthCheckRequested()),
      );
    });


    _authenticationSubscription = authRepository.user.listen((event) => add(AuthCheckRequested()));


    /// This is for testing purposes without using [FirebaseAuth] should be deleted after having a firebase account
    on<AuthCheckRequestedTest>((event, emit) async {
      switch(event.status) {
        case AuthenticationStatus.unauthenticated:
          return emit(Unauthenticated());
        case AuthenticationStatus.authenticated:
          return emit(Authenticated(null));
        case AuthenticationStatus.unknown:
          return emit(Unknown());
      }
    });

    /// This is for testing purposes without using [FirebaseAuth] should be deleted after having a firebase account
    // _authenticationSubscriptionTest = authRepository.status.listen((event) 
    //   => add(AuthCheckRequestedTest(event as AuthenticationStatus))) as StreamSubscription<AuthenticationStatus>;
  }
}