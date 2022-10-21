import 'package:dartz/dartz.dart';
import 'package:collaction_admin/domain/core/value_failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  
  if(input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  }

  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

/// If [onlyIsEmpty] is set to true, [validatePassword] is going to check only if the password is empty.
/// During Sign In, usually the user can write any password without validation; but in the Sign up process
/// usually there are validations.
Either<ValueFailure<String>, String> validatePassword(String input, bool onlyIsEmpty) {
  const String charRegex = r"(?=.{8,})";
  const String uppercaserRegex = r"(?=.*[A-Z])";
  const String lowercaseRegex = r"(?=.*[a-z])";
  const String digitRegex = r"(?=.*[0-9])";

  if(input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  } else {
    if(onlyIsEmpty) return right(input);

    if(!RegExp(charRegex).hasMatch(input)) return left(ValueFailure.shortPassword(failedValue: input));

    if(!RegExp(uppercaserRegex).hasMatch(input)) return left(ValueFailure.nonUppercasePassword(failedValue: input));

    if(!RegExp(lowercaseRegex).hasMatch(input)) return left(ValueFailure.nonLowercasePassword(failedValue: input));

    if(!RegExp(digitRegex).hasMatch(input)) return left(ValueFailure.allLettersPassword(failedValue: input));

    return right(input);
  }
}

