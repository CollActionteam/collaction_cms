import 'package:country_codes/country_codes.dart';
import 'package:dartz/dartz.dart';
import 'package:collaction_cms/domain/core/value_failures.dart';

class ValidationOutput {
  final bool error;
  final dynamic output;

  ValidationOutput({required this.error, this.output = ""});
}

ValidationOutput validateEmailAddress(String input) {
  const emailRegex =
      r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  if (input.isEmpty) {
    return ValidationOutput(error: true, output: "Email cannot be empty");
  }

  if (!RegExp(emailRegex).hasMatch(input)) {
    return ValidationOutput(error: true, output: "Email is not valid");
  }

  if (!input.endsWith("@collaction.org")) {
    return ValidationOutput(
        error: true, output: "Must be a collaction.org email");
  }

  return ValidationOutput(error: false, output: input);
}

ValidationOutput validatePassword(String input) {
  const String charRegex = r"(?=.{8,})";
  if (input.isEmpty) {
    return ValidationOutput(error: true, output: "Password cannot be empty");
  } else {
    if (!RegExp(charRegex).hasMatch(input)) {
      return ValidationOutput(
          error: true, output: "Password cannot be less than 8 characters");
    }

    return ValidationOutput(error: false, output: input);
  }
}

ValidationOutput validateConfirmPassword(String input, String password) {
  if (input.isEmpty) {
    return ValidationOutput(error: true, output: "Password cannot be empty");
  }

  if (input != password) {
    return ValidationOutput(error: true, output: "The passwords don't match");
  }

  return ValidationOutput(error: false, output: input);
}

ValidationOutput validateIncompleteDateTimeField(
  DateTime? input,
  bool dateFilled,
  bool timeFilled,
) {
  if (input == null || !dateFilled) {
    return ValidationOutput(error: true, output: "Field cannot be empty");
  }

  if (!timeFilled) {
    return ValidationOutput(error: true, output: "Time field must be filled");
  }

  return ValidationOutput(error: false, output: input);
}

ValidationOutput validateEmptyField(dynamic input,
    [String customMessage = "Field cannot be emtpy"]) {
  if (input is List<dynamic> && input.contains(null)) {
    return ValidationOutput(error: true, output: customMessage);
  }

  if (input == null || (input is String && input.isEmpty)) {
    return ValidationOutput(error: true, output: customMessage);
  }

  return ValidationOutput(error: false, output: input);
}
