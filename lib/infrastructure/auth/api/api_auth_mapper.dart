part of 'auth_failure_dto.dart';

extension AuthFailureDtoX on AuthFailureDto {
  AuthFailure toDomainAuthFailure() {
    if (errorMessage == "invalid-continue-uri") {
      return const AuthFailure.invalidUri("Invalid-url");
    }

    if (errorMessage == "user-not-found") {
      return const AuthFailure.userNotFound("Uid not found");
    } else {
      return const AuthFailure.serverError("Server error");
    }
  }
}
