import 'package:collaction_admin/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Stream<Option<User>> get user;
  Stream<Option<String>> get idToken;

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    String email,
    String password,
  });

  Future<void> signOut();
}
