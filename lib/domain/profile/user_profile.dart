import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user.dart';
import 'profile.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required User user,
    required Profile profile,
    required Role role,
  }) = _UserProfile;
}

enum Role {
  @JsonValue('ADMIN')
  admin,
  @JsonValue("MODERATOR")
  moderator;

  static Role? enumOf(String? input) {
    switch (input) {
      case "ADMIN":
        return Role.admin;
      case "MODERATOR":
        return Role.moderator;
      default:
        return null;
    }
  }
}
