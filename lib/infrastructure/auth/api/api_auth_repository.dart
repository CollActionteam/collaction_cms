import 'dart:async';
import 'dart:convert';
import 'package:collaction_admin/infrastructure/auth/api/auth_failure_dto.dart';
import 'package:http/http.dart' as http;

import 'package:collaction_admin/domain/auth/auth_failure.dart';
import 'package:collaction_admin/domain/auth/i_auth_client_repository.dart';
import 'package:collaction_admin/domain/auth/i_auth_api_repository.dart';
import 'package:collaction_admin/domain/core/i_settings_repository.dart';
import 'package:collaction_admin/infrastructure/core/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:collaction_admin/infrastructure/auth/firebase/firebase_auth_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

/// -----------------------------ENDPOINTS ARE NOT IMPLEMENTED YET New Auth Flow-------------------------///
@LazySingleton(as: IAuthApiRepository)
class AuthApiRepository implements IAuthApiRepository {
  final http.Client _client;
  final ISettingsRepository _settingsRepository;
  final IAuthClientRepository _authClientRepository;

  AuthApiRepository(
      this._client, this._settingsRepository, this._authClientRepository);

  @override
  Future<Either<AuthFailure, Unit>> sendEmailLinkAuth({
    String? email,
    ActionCodeSettings? actionCodeSettings,
  }) async {
    try {
      final user = await _authClientRepository.user.first;
      late final String tokenId;
      user.map((user) async {
        tokenId = await user.getIdToken();
      });

      final uri = Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/auth/invite-admin');

      final response = await _client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $tokenId'
          },
          body: jsonEncode({
            'email': email,
            'url': actionCodeSettings!.url,
            'handleCodeInApp': actionCodeSettings.url
          }));

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        final authFailureDto = AuthFailureDto.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return left(authFailureDto.toDomainAuthFailure());
      }
    } catch (e) {
      return left(const AuthFailure.serverError("Server error"));
    }
  }

  @override
  Future<Either<AuthFailure, String>> verifiyUser({
    String? email,
    String? emailLink,
  }) async {
    try {
      final uri = Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/auth/verify-email');

      final response = await _client.post(uri,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'emailLink': emailLink}));

      if (response.statusCode == 200) {
        final Option<String> uid =
            optionOf((jsonDecode(response.body) as Map<String, String>)["uid"]);

        return uid.fold(
            () =>
                left(const AuthFailure.emptyUid("Empty uid sent by the backe")),
            (uid) => right(uid));
      } else {
        final authFailureDto = AuthFailureDto.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return left(authFailureDto.toDomainAuthFailure());
      }
    } catch (e) {
      return left(const AuthFailure.serverError("Server error"));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> addPassword(
      {String? uid, String? password}) async {
    try {
      final uri = Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/auth/add-password');

      final response = await _client.post(uri,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({uid: uid, password: password}));

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        final authFailureDto = AuthFailureDto.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return left(authFailureDto.toDomainAuthFailure());
      }
    } catch (e) {
      return left(const AuthFailure.serverError("Server error"));
    }
  }
}
