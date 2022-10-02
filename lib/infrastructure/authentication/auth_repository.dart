import 'dart:async';

import 'package:collaction_admin/domain/authentication/auth_failure.dart';
import 'package:collaction_admin/domain/authentication/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';



@lazySingleton
class AuthRepository implements IAuthRepository {
  AuthRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  @override
  Stream<Option<User>> get user => firebaseAuth
    .authStateChanges()
    .map((currentUser) => optionOf(currentUser));

  @override
  Stream<Option<String>> get idToken => firebaseAuth
    .authStateChanges()
    .asyncMap<Option<String>>((currentUser) async {
      try {
        final idToken = await currentUser?.getIdToken();
        return optionOf(idToken);
      } catch(e) {
        throw Exception("Firebase Auth/API Failed");
      }
    });

  Stream<Option<String>> get roleOption => firebaseAuth
    .authStateChanges()
    .asyncMap<Option<String>>((currentUser) async {
      final role = await currentUser?.getIdTokenResult().then(
        (idTokenResult) => idTokenResult.claims!.containsKey("role")
        ? idTokenResult.claims!["role"] as String
        : null
      );
      return optionOf(role);
    });

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    String? email, 
    String? password
  }) async {
    if (email == null || password == null) {
      return left(
        const AuthFailure(message: 'Email and/or password can not be empty')
      );
    }

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      return await roleOption.first.then(
        (option) => option.fold(
          () => incorrectRole(),
          (role) => role == 'ADMIN' ? right(unit) : incorrectRole()
        )
      );
    } on FirebaseAuthException catch (error) {
      if(error.code == 'wrong-password' || error.code == 'user-not-found') {
        return left(
          const AuthFailure(
            message: 'Invalid email and password combination'
          )
        );
      } else if (error.code == 'user-disabled') {
        return left(const AuthFailure(message: 'User is disabled'));
      } else {
        return left(const AuthFailure(message: 'An unknown error ocurred'));
      }
    }
  } 

  @override
  Future<void> signOut() => firebaseAuth.signOut();

  Either<AuthFailure,Unit> incorrectRole() => left(
    const AuthFailure(
      message: 'User must be an Admin to access the AdminCMS'
    )
  );
 }

/// This is for testing purposes without using [FirebaseAuth] shuld be deleted after having a firebase account
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

