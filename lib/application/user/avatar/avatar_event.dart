part of 'avatar_bloc.dart';

@freezed
class AvatarEvent with _$AvatarEvent {
  const factory AvatarEvent.uploadAvatar(File image) = _UploadAvatar;
}
