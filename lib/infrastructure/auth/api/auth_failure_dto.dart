import 'package:collaction_cms/domain/auth/auth_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure_dto.freezed.dart';
part 'auth_failure_dto.g.dart';
part 'api_auth_mapper.dart';

@freezed
class AuthFailureDto with _$AuthFailureDto {
  AuthFailureDto._();

  factory AuthFailureDto({required String errorMessage}) = _AuthFailureDto;

  factory AuthFailureDto.fromJson(Map<String, dynamic> json) =>
      _$AuthFailureDtoFromJson(json);
}
