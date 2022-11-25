import 'package:collaction_cms/domain/auth/auth_failure.dart';
import 'package:collaction_cms/domain/auth/preauth_credential.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthApiRepository {

  Future<Either<AuthFailure, Unit>> sendEmailLinkAuth({
    String email,
    ActionCodeSettings actionCodeSettings,
  });

  Future<Either<AuthFailure, PreAuthCredential>> verifiyUser({
    String email,
    String url,
  });

  Future<Either<AuthFailure, Unit>> addPassword({
    String uid,
    String password,
    String token
  });

}