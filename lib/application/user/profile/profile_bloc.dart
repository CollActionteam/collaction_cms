import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_cms/application/user/username/username_bloc.dart';
import 'package:collaction_cms/domain/profile/i_profile_repository.dart';
import 'package:collaction_cms/domain/profile/user_profile.dart';
import 'package:collaction_cms/application/user/avatar/avatar_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository profileRepository;
  final AvatarBloc _avatarBloc;
  final UsernameBloc _usernameBloc;
  late StreamSubscription avatarBlocSubscription;
  late StreamSubscription usernameBlocSubscription;

  UserProfile? userProfile;

  ProfileBloc(this.profileRepository, this._avatarBloc, this._usernameBloc)
      : super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.map(
        getUserProfile: (event) async => await _getUserProfile(emit, event),
        createUserProfile: (event) async => await _createUserProfile(
          emit,
          event,
        ),
      );
    });

    avatarBlocSubscription = _avatarBloc.stream.listen((state) {
      state.mapOrNull(
        uploadSuccess: (_) {
          add(const ProfileEvent.getUserProfile());
        },
      );
    });

    usernameBlocSubscription = _usernameBloc.stream.listen((state) {
      state.mapOrNull(
        updateSuccess: (_) => add(const ProfileEvent.getUserProfile()),
      );
    });
  }

  Future<void> _getUserProfile(
    Emitter<ProfileState> emit,
    _GetUserProfile event,
  ) async {
    final userProfileOption = await profileRepository.getUserProfile();

    emit(
      userProfileOption.fold(
        (failure) => const ProfileState.profileError(),
        (userProfile) => ProfileState.profileFound(userProfile),
      ),
    );
  }

  Future<void> _createUserProfile(
    Emitter<ProfileState> emit,
    _CreateUserProfile event,
  ) async {
    final createUserOption = await profileRepository.createProfile();
    emit(createUserOption.fold(
      (failure) => const ProfileState.profileError(),
      (success) => const ProfileState.profileFound(null),
    ));
  }
}
