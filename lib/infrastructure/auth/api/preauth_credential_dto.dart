import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/auth/preauth_credential.dart';

part 'preauth_credential_dto.freezed.dart';
part 'preauth_credential_dto.g.dart';

@freezed
class PreAuthCredentialDto with _$PreAuthCredentialDto {
  PreAuthCredentialDto._();

  factory PreAuthCredentialDto(
      {required String identifier,
      required String token}) = _PreAuthCredentialDto;

  factory PreAuthCredentialDto.fromJson(Map<String, dynamic> json) =>
      _$PreAuthCredentialDtoFromJson(json);

  PreAuthCredential toDomain() {
    return PreAuthCredential(
      identifier: identifier,
      token: token,
    );
  }
}
