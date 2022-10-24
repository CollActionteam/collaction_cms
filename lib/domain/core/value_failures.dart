import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    required T failureMessage,
  }) = InvalidEmail<T>;

  const factory ValueFailure.empty({
    required T failureMessage,
  }) = Empty<T>;

  const factory ValueFailure.shortPassword({
    required T failureMessage,
  }) = ShortPassword<T>;

  const factory ValueFailure.nonUppercasePassword({
    required T failureMessage,
  }) = NonUppercasePassword<T>;

  const factory ValueFailure.nonLowercasePassword({
    required T failureMessage,
  }) = NonLowercasePassword<T>;

  const factory ValueFailure.allLettersPassword({
    required T failureMessage,
  }) = AllLettersPassword<T>;
}

