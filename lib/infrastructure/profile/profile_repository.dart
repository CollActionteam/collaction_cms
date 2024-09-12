import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collaction_cms/infrastructure/auth/firebase/firebase_auth_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:image/image.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

import '../../domain/auth/i_auth_client_repository.dart';
import '../../domain/core/i_settings_repository.dart';
import '../../domain/profile/user_profile.dart';
import '../../domain/profile/i_profile_repository.dart';
import '../../domain/profile/profile_failure.dart';
import '../../domain/user/user.dart';
import '../../infrastructure/profile/profile_dto.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final IAuthClientRepository _authRepository;
  final http.Client _client;
  final ISettingsRepository _settingsRepository;

  const ProfileRepository(
    this._authRepository,
    this._client,
    this._settingsRepository,
  );

  @override
  Future<Either<ProfileFailure, UserProfile>> getUserProfile() async {
    try {
      final userOption = await _authRepository.user.first;

      return await userOption.fold(
        () => left(const ProfileFailure.noUser()),
        (user) async {
          var userProfile = await _getUserProfile(user.toDomain());

          if (userProfile != null) {
            return right(userProfile);
          }

          final resultOrFailure = await createProfile();

          if (resultOrFailure.isRight()) {
            userProfile = await _getUserProfile(user.toDomain());
            return right(userProfile!);
          }

          return left(const ProfileFailure.noUser());
        },
      );
    } catch (_) {
      return left(const ProfileFailure.unexpected());
    }
  }

  @override
  Future<Either<ProfileFailure, Unit>> createProfile() async {
    try {
      final userOption = await _authRepository.user.first;

      return await userOption.fold(
        () => left(const ProfileFailure.noUser()),
        (user) async {
          final tokenId = await user.getIdToken();

          final response = await _client.post(
            Uri.parse(
              '${await _settingsRepository.baseApiEndpointUrl}/v1/profiles',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $tokenId',
            },
            body: jsonEncode({
              "firstName": "John",
              "lastName": "Doe",
              "country": "NL",
              "bio": "My bio is currently empty",
            }),
          );

          if (response.statusCode == 201) {
            return right(unit);
          }

          return left(const ProfileFailure.unexpected());
        },
      );
    } catch (_) {
      return left(const ProfileFailure.unexpected());
    }
  }

  @override
  Future<Either<ProfileFailure, Unit>> updateUsername({
    String? firstName,
    String? lastName,
  }) async {
    try {
      final userOption = await _authRepository.user.first;

      return await userOption.fold(
        () => left(const ProfileFailure.noUser()),
        (user) async {
          final token = await user.getIdToken();

          final response = await _client.put(
            Uri.parse(
              '${await _settingsRepository.baseApiEndpointUrl}/v1/profiles',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              "firstName": firstName,
              "lastName": lastName,
            }),
          );

          if (response.statusCode == 200) {
            return right(unit);
          }

          return left(const ProfileFailure.unexpected());
        },
      );
    } catch (_) {
      return left(const ProfileFailure.unexpected());
    }
  }

  @override
  Future<Either<ProfileFailure, Unit>> uploadAvatar(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      final imageResized = copyResize(decodeImage(imageBytes)!, width: 200);
      final resizedBytes = encodePng(imageResized);

      final userOption = await _authRepository.user.first;
      return await userOption.fold(() => left(const ProfileFailure.noUser()),
          (user) async {
        final token = await user.getIdToken();
        final request = http.MultipartRequest(
          'POST',
          Uri.parse(
            '${await _settingsRepository.baseApiEndpointUrl}/v1/profiles/me/image',
          ),
        );

        request.headers['Authorization'] = 'Bearer $token';
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            resizedBytes,
            contentType: MediaType('image', 'png'),
            filename: basename(imageFile.path),
          ),
        );

        final response = await request.send();

        if ([201, 200].contains(response.statusCode)) {
          return right(unit);
        } else {
          return left(const ProfileFailure.avatarUploadFailure());
        }
      });
    } catch (_) {
      return left(const ProfileFailure.avatarUploadFailure());
    }
  }

  /// Get user profile from api
  Future<UserProfile?> _getUserProfile(User user) async {
    final tokenId = await user.getIdToken();

    final response = await _client.get(
      Uri.parse(
        '${await _settingsRepository.baseApiEndpointUrl}/v1/profiles/me',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenId'
      },
    );

    final roleOption = await _authRepository.roleOption.first;
    roleOption.fold(
      () => null,
      (role) {
        final roleEnum = Role.enumOf(role);
        if (roleEnum == null) return null;

        /// Return profile if request is successful
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);

          final profile =
              ProfileDto.fromJson(json as Map<String, dynamic>).toDomain();

          return UserProfile(user: user, profile: profile, role: roleEnum);
        }
      },
    );

    return null;
  }
}
