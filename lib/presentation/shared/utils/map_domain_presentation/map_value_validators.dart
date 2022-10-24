import 'dart:async';

import 'package:collaction_admin/domain/auth/value_validators.dart';
import 'package:collaction_admin/domain/core/value_failures.dart';
import 'package:dartz/dartz.dart';


///Transform [Either] of [ValueFailure] & [String] to a [MapValidationOutput] so that it can be handled easily 
///in presentation screens. If [error] = true, the output should be the error message, if [error] is false then 
///the output should be the value. 

class MapValidationOutput {

  MapValidationOutput({
    required this.error,
    required this.output
  });

  bool error;
  String output;
 
}

MapValidationOutput mapValidation(Either<ValueFailure<String>, String> domainValidationOutput) {

    late MapValidationOutput mapValidationOutput = MapValidationOutput(error: false, output: "");

    domainValidationOutput.fold(
      (l) {
        mapValidationOutput.error = true;
        mapValidationOutput.output = l.failureMessage;
      }, 
      (r) {
        mapValidationOutput.error = false;
        mapValidationOutput.output = r;
      });

      return mapValidationOutput;
  }

