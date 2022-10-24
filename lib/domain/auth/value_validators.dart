import 'package:dartz/dartz.dart';
import 'package:collaction_admin/domain/core/value_failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  
  if(input.isEmpty) {
    return left(const ValueFailure.empty(failureMessage: "Email cannot be empty"));
  }

  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(const ValueFailure.invalidEmail(failureMessage: "Email is not valid"));
  }
}

Either<ValueFailure<String>, String> validatePasswordSimple(String input) {

  if(input.isEmpty) {
    return left(const ValueFailure.empty(failureMessage: "Password cannot be empty"));
  }

  return right(input);
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  const String charRegex = r"(?=.{8,})";
  const String uppercaserRegex = r"(?=.*[A-Z])";
  const String lowercaseRegex = r"(?=.*[a-z])";
  const String digitRegex = r"(?=.*[0-9])";


  if(input.isEmpty) {
    return left(const ValueFailure.empty(
      failureMessage: "Password cannot be empty"));
  } else {

    if(!RegExp(charRegex).hasMatch(input)) {
      return left(
      const ValueFailure.shortPassword(
        failureMessage: "Password cannot be less than 8 char"));
    } 

    if(!RegExp(uppercaserRegex).hasMatch(input)) {
      return left(
      const ValueFailure.nonUppercasePassword(
        failureMessage: "Password must contain an uppercase letter"));
    } 

    if(!RegExp(lowercaseRegex).hasMatch(input)) {
      return left(
      const ValueFailure.nonLowercasePassword(
        failureMessage: "Password must contain a lowercase letter"));

    } 
    if(!RegExp(digitRegex).hasMatch(input)) {
      return left(
      const ValueFailure.allLettersPassword(
        failureMessage: "Password must contain at least a number"));
    } 

    return right(input);
  }
}



