part of 'profile_bloc.dart';

/*class ProfileState {
  const ProfileState({
    required this.userProfile,
  });

  final UserProfile? userProfile;

  factory ProfileState.initial() => const ProfileState(
        userProfile: null,
      );

  ProfileState copyWith({
    UserProfile? userProfile,
  }) {
    return ProfileState(
      userProfile: userProfile ?? this.userProfile,
    );
  }
}*/
@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  const factory ProfileState.profileError() = _ProfileError;

  const factory ProfileState.profileFound(UserProfile? userProfile) =
      _ProfileFound;
}
