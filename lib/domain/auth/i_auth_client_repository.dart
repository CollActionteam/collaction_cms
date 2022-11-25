import 'package:collaction_cms/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthClientRepository {
  Stream<Option<User>> get user;

  Stream<Option<String>> get idToken;

  Stream<Option<String>> get roleOption;

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    String email, 
    String password,
  });

  Future<Either<AuthFailure, Unit>> sendEmailLinkAuth({
    String email,
    ActionCodeSettings actionCodeSettings,
  });

  Future<Either<AuthFailure, dynamic>> signInWithEmailLink({
    String email,
    String emailLink,
  });

  Future<void> signOut(); 
}
