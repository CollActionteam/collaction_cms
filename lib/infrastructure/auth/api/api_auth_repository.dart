import 'dart:async';
import 'dart:convert';
import 'package:collaction_cms/domain/auth/preauth_credential.dart';
import 'package:collaction_cms/infrastructure/auth/api/auth_failure_dto.dart';
import 'package:collaction_cms/infrastructure/auth/api/preauth_credential_dto.dart';
import 'package:http/http.dart' as http;

import 'package:collaction_cms/domain/auth/auth_failure.dart';
import 'package:collaction_cms/domain/auth/i_auth_client_repository.dart';
import 'package:collaction_cms/domain/auth/i_auth_api_repository.dart';
import 'package:collaction_cms/domain/core/i_settings_repository.dart';
import 'package:collaction_cms/infrastructure/core/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:collaction_cms/infrastructure/auth/firebase/firebase_auth_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

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
      late final Future<String> tokenId;
      user.map((user) async {
        tokenId = user.getIdToken();
      });

      final uri = Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/auth/invite-admin');

      final response = await _client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await tokenId}'
          },
          body: jsonEncode({
            'email': email,
          }));

      if (response.statusCode.toString().startsWith("20")) {
        return right(unit);
      } else {
        final authFailureDto = AuthFailureDto.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return left(authFailureDto.toDomainAuthFailure());
      }
    } catch (e) {
      print(e);
      return left(const AuthFailure.serverError("Server error"));
    }
  }

  @override
  Future<Either<AuthFailure, PreAuthCredential>> verifiyUser({
    String? email,
    String? url,
  }) async {
    try {
      final uri = Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/auth/verify-email');

      final response = await _client.post(uri,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'url': url}));

      if (response.statusCode.toString().startsWith("20")) {
        if(response.body.isEmpty) {
          return left( const AuthFailure.missingValues("Missing values from backend response"));
        }

        final PreAuthCredentialDto preAuthCredentialDto = 
            PreAuthCredentialDto.fromJson(
              (jsonDecode(response.body) as Map<String, dynamic>)
            );
        
        return right(preAuthCredentialDto.toDomain());
            
      } else {
        final authFailureDto = AuthFailureDto.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return left(authFailureDto.toDomainAuthFailure());
      }
    } catch (e) {
      print(e);
      return left(const AuthFailure.serverError("Server error"));
    }
  }

  // @override
  // Future<Either<AuthFailure, Unit>> addPassword(
  //     {String? uid, String? password, String? token}) async {
  //       print("$uid, $password, $token");
  //   try {
  //     final uri = Uri.parse(
  //         '${await _settingsRepository.baseApiEndpointUrl}/v1/auth/update-password');

  //     final response = await _client.post(uri,
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token'
  //           },
  //         body: jsonEncode({'password': password}));

  //     if (response.statusCode.toString().startsWith("20")) {
  //       return right(unit);
  //     } else {
  //       final authFailureDto = AuthFailureDto.fromJson(
  //           jsonDecode(response.body) as Map<String, dynamic>);
  //       return left(authFailureDto.toDomainAuthFailure());
  //     }
  //   } catch (e) {
  //     print(e);
  //     return left(const AuthFailure.serverError("Server error"));
  //   }
  // }

  ///Without token, just with uid
  @override
  Future<Either<AuthFailure, Unit>> addPassword(
      {String? uid, String? password, String? token}) async {
        print("$uid, $password, $token");
    try {
      final uri = Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/auth/update-password');

      final response = await _client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
            },
          body: jsonEncode({'uid': uid, 'password': password}));

      if (response.statusCode.toString().startsWith("20")) {
        return right(unit);
      } else {
        final authFailureDto = AuthFailureDto.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return left(authFailureDto.toDomainAuthFailure());
      }
    } catch (e) {
      print(e);
      return left(const AuthFailure.serverError("Server error"));
    }
  }
}
