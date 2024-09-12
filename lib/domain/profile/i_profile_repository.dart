import 'dart:io';

import 'package:dartz/dartz.dart';

import '../profile/user_profile.dart';
import 'profile_failure.dart';

abstract class IProfileRepository {
  Future<Either<ProfileFailure, UserProfile>> getUserProfile();
  Future<Either<ProfileFailure, Unit>> createProfile();
  Future<Either<ProfileFailure, Unit>> updateUsername({
    String? firstName,
    String? lastName,
  });
  Future<Either<ProfileFailure, Unit>> uploadAvatar(File file);
}
