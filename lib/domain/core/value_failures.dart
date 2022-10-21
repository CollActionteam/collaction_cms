import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;

  const factory ValueFailure.shortPassword({
    required T failedValue,
  }) = ShortPassword<T>;

  const factory ValueFailure.nonUppercasePassword({
    required T failedValue,
  }) = NonUppercasePassword<T>;

  const factory ValueFailure.nonLowercasePassword({
    required T failedValue,
  }) = NonLowercasePassword<T>;

  const factory ValueFailure.allLettersPassword({
    required T failedValue,
  }) = AllLettersPassword<T>;
}