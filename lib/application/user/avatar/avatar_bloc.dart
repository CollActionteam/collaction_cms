import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collaction_cms/domain/profile/i_profile_repository.dart';

part 'avatar_bloc.freezed.dart';
part 'avatar_event.dart';
part 'avatar_state.dart';

@injectable
class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final IProfileRepository profileRepository;

  AvatarBloc(this.profileRepository) : super(const AvatarState.initial()) {
    on<AvatarEvent>((event, emit) async {
      await event.map(
        uploadAvatar: (event) async => await _uploadAvatar(emit, event),
      );
    });
  }

  Future<void> _uploadAvatar(
    Emitter<AvatarState> emit,
    _UploadAvatar event,
  ) async {
    emit(const AvatarState.uploading());
    final result = await profileRepository.uploadAvatar(event.image);
    emit(
      result.fold(
        (failure) => const AvatarState.uploadFail(),
        (success) => const AvatarState.uploadSuccess(),
      ),
    );
  }
}
