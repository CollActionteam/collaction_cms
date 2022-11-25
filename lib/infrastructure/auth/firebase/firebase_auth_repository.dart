import 'dart:async';

import 'package:collaction_cms/domain/auth/auth_failure.dart';
import 'package:collaction_cms/domain/auth/i_auth_client_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:collaction_cms/infrastructure/auth/firebase/firebase_auth_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthClientRepository)
class AuthRepository implements IAuthClientRepository {
  AuthRepository(this.firebaseAuth);

  final firebase_auth.FirebaseAuth firebaseAuth;

  @override
  Stream<Option<firebase_auth.User>> get user => firebaseAuth
      .authStateChanges()
      .map((currentUser) => optionOf(currentUser));

  @override
  Stream<Option<String>> get idToken => firebaseAuth
          .authStateChanges()
          .asyncMap<Option<String>>((currentUser) async {
        try {
          final idToken = await currentUser?.getIdToken();
          return optionOf(idToken);
        } catch (e) {
          throw Exception("Firebase Auth/API Failed");
        }
      });

  @override
  Stream<Option<String>> get roleOption => firebaseAuth
          .authStateChanges()
          .asyncMap<Option<String>>((currentUser) async {
        final role = await currentUser?.getIdTokenResult().then(
            (idTokenResult) => idTokenResult.claims!.containsKey("role")
                ? idTokenResult.claims!["role"] as String
                : null);
        return optionOf(role);
      });

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    if (email == null || password == null) {
      return left(const AuthFailure.invalidEmail("Invalid email or password"));
    }

    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return await roleOption.first.then((option) => option.fold(
          () => incorrectRole(),
          (role) => role == 'ADMIN' ? right(unit) : incorrectRole()));
    } on firebase_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError("Server error"));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendEmailLinkAuth(
      {String? email,
      firebase_auth.ActionCodeSettings? actionCodeSettings}) async {
    if (email == null || actionCodeSettings == null) {
      return left(const AuthFailure.invalidUri("Invalid Uri"));
    }
    try {
      await firebaseAuth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: actionCodeSettings);

      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError("Server Error"));
    }
  }

  @override
  Future<Either<AuthFailure, firebase_auth.User>> signInWithEmailLink(
      {String? email, String? emailLink}) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailLink(
          email: email!, emailLink: emailLink!);

      return right(userCredential.user!);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError("Server Error"));
    }
  }

  @override
  Future<void> signOut() => firebaseAuth.signOut();

  Either<AuthFailure, Unit> incorrectRole() =>
      left(const AuthFailure.incorrectRole("Admin role not found"));
}
