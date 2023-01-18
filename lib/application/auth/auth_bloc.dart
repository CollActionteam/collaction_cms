import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:collaction_cms/domain/auth/auth_failure.dart';
import 'package:collaction_cms/domain/auth/i_auth_api_repository.dart';
import 'package:collaction_cms/domain/auth/i_auth_client_repository.dart';
import 'package:collaction_cms/domain/auth/i_auth_client_repository.dart';
import 'package:collaction_cms/domain/auth/preauth_credential.dart';
import 'package:collaction_cms/infrastructure/auth/firebase/firebase_auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthClientRepository authRepository;
  final IAuthApiRepository authApiRepository;

  User? authedUser;

  late StreamSubscription<Option<User>> _authenticationSubscription;

  AuthBloc(this.authRepository, this.authApiRepository)
      : super(const AuthState.unknown()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
          authCheckRequested: (event) async =>
              await _mapAuthCheckRequested(emit, event),
          signedOut: (event) async => await _mapSignedOut(emit, event),
          signInWithEmailAndPassword: (event) async =>
              await _mapSignInWithEmailAndPassword(emit, event),
          toVerification: (event) async =>
              await _mapVerificationRequested(emit, event),
          sendSignInLinkToEmail: (event) async =>
              await _mapSendSignInLinkToEmail(emit, event),
          verifyUser: (event) async => await _mapVerifyUser(emit, event),
          addPassword: (event) async => await _mapAddPassword(emit, event));
    });

    if (window.location.href.contains("/verification")) {
      add(AuthEvent.toVerification(
          window.location.href, window.location.pathname!));
    } else {
      _authenticationSubscription = authRepository.user
          .listen((event) => add(const AuthEvent.authCheckRequested()));
    }
  }

  Future<void> _mapAuthCheckRequested(
      Emitter<AuthState> emit, _AuthCheckRequested event) async {
    final userOption = await authRepository.user.first;
    final userRole = await authRepository.roleOption.first;

    if (userOption.isSome() && userRole.isSome()) {
      late String? providerId;
      late User authedUser;

      userOption.map((user) {
        providerId = user.providerData[0].providerId;
        authedUser = user;
      });
      if (providerId != null) {
        emit(AuthState.authenticated(authedUser));
      } else {
        emit(const AuthState.unaunthenticated());
      }
    } else {
      emit(const AuthState.unaunthenticated());
    }
  }

  FutureOr<void> _mapSignedOut(
      Emitter<AuthState> emit, _SignedOut event) async {
    await authRepository.signOut();
    emit(const AuthState.unaunthenticated());
  }

  FutureOr<void> _mapSignInWithEmailAndPassword(
      Emitter<AuthState> emit, _SignInWithEmailAndPassword event) async {
    emit(const AuthState.signingInUser());
    final result = await authRepository.signInWithEmailAndPassword(
        email: event.email, password: event.password);

    result.fold((failure) => emit(AuthState.authError(failure)),
        (user) => add(const AuthEvent.authCheckRequested()));
  }

  FutureOr<void> _mapVerificationRequested(
      Emitter<AuthState> emit, _ToVerification event) async {
    emit(AuthState.onVerification(event.href, event.pathname));
  }

  ///---------------------------------------Handlers for new auth flow------------------------------------------------///

  FutureOr<void> _mapSendSignInLinkToEmail(
      Emitter<AuthState> emit, _SendSignInLinkToEmail event) async {
    emit(const AuthState.invitingAdmin());
    final result = await authApiRepository.sendEmailLinkAuth(
        email: event.email, actionCodeSettings: event.actionCodeSettings);

    result.fold((failure) => emit(AuthState.authError(failure)),
        (_) => emit(const AuthState.inviteAdminDone()));
  }

  FutureOr<void> _mapVerifyUser(
      Emitter<AuthState> emit, _VerifyUser event) async {
    emit(const AuthState.verifyingUser());
    final result =
        await authApiRepository.verifiyUser(email: event.email, url: event.url);

    result.fold((failure) => emit(AuthState.authError(failure)),
        (preAuthCredential) {
      emit(AuthState.preAuthenticated(preAuthCredential.addEmail(event.email)));
    });
    // (preAuthCredential) => emit(AuthState.preAuthenticated(preAuthCredential.addEmail(event.email))));
  }

  FutureOr<void> _mapAddPassword(
      Emitter<AuthState> emit, _AddPassword event) async {
    emit(const AuthState.addingPassword());
    final result = await authApiRepository.addPassword(
        uid: event.uid, password: event.password, token: event.token);

    result.fold((failure) => emit(AuthState.authError(failure)), (_) {
      emit(const AuthState.adminCreationCompleted());
      add(const AuthEvent.signedOut());
    });
  }
}
