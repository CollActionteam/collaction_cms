import 'package:bloc/bloc.dart';
import 'package:collaction_admin/domain/authentication/i_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthRepository authRepository;
  User? authedUser;

  AuthenticationBloc(this.authRepository) : super(Unauthenticated()) {
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
  }
}
