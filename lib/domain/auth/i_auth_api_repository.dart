import 'package:collaction_admin/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthApiRepository {

  Future<Either<AuthFailure, Unit>> sendEmailLinkAuth({
    String email,
    ActionCodeSettings actionCodeSettings,
  });

  Future<Either<AuthFailure, String>> verifiyUser({
    String email,
    String emailLink,
  });

  Future<Either<AuthFailure, Unit>> addPassword({
    String uid,
    String password
  });

}