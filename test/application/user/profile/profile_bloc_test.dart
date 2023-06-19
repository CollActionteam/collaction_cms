import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_cms/application/user/avatar/avatar_bloc.dart';
import 'package:collaction_cms/application/user/profile/profile_bloc.dart';
import 'package:collaction_cms/application/user/username/username_bloc.dart';
import 'package:collaction_cms/domain/profile/profile_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities.dart';

void main() {
  group("Testing profile bloc events and stream listeners", () {
    late final MockProfileRepository profileRepository;
    late AvatarBloc avatarBloc;
    late UsernameBloc usernameBloc;
    late ProfileBloc profileBloc;
    final File file = File('tFile');

    setUpAll(() {
      profileRepository = MockProfileRepository();
    });

    setUp(() {
      avatarBloc = AvatarBloc(profileRepository);
      usernameBloc = UsernameBloc(profileRepository);
      profileBloc = ProfileBloc(profileRepository, avatarBloc, usernameBloc);
    });

    test('Initial state', () {
      expect(profileBloc.state, const ProfileState.initial());
    });

    blocTest(
      'createUserProfile success',
      build: () => profileBloc,
      act: (profileBloc) {
        when(() => profileRepository.createProfile()).thenAnswer(
          (_) => Future.value(
            right(unit),
          ),
        );

        profileBloc.add(const ProfileEvent.createUserProfile());
      },
      expect: () => [const ProfileState.profileFound(null)],
    );

    blocTest(
      'createUserProfile fail',
      build: () => profileBloc,
      act: (profileBloc) {
        when(() => profileRepository.createProfile()).thenAnswer(
          (_) => Future.value(
            left(const ProfileFailure.unexpected()),
          ),
        );

        profileBloc.add(const ProfileEvent.createUserProfile());
      },
      expect: () => [const ProfileState.profileError()],
    );

    blocTest(
      'getUserProfile fail',
      build: () => profileBloc,
      act: (profileBloc) {
        when(() => profileRepository.getUserProfile()).thenAnswer(
          (_) => Future.value(
            left(const ProfileFailure.noUser()),
          ),
        );

        profileBloc.add(const ProfileEvent.getUserProfile());
      },
      expect: () => [const ProfileState.profileError()],
    );

    blocTest(
      'getUserProfile success',
      build: () => profileBloc,
      act: (profileBloc) {
        when(() => profileRepository.getUserProfile()).thenAnswer(
          (_) => Future.value(
            right(tAdminUserProfile),
          ),
        );

        profileBloc.add(const ProfileEvent.getUserProfile());
      },
      expect: () => [const ProfileState.profileFound(tAdminUserProfile)],
    );

    blocTest(
      'getUserProfile event triggers when AvatarBloc emits success',
      build: () => profileBloc,
      act: (profileBloc) {
        when(() => profileRepository.getUserProfile())
            .thenAnswer((_) => Future.value(right(tAdminUserProfile)));
        when(() => profileRepository.uploadAvatar(file)).thenAnswer(
          (_) => Future.value(right(unit)),
        );
        avatarBloc.add(AvatarEvent.uploadAvatar(file));
      },
      expect: () => [
        const ProfileState.profileFound(tAdminUserProfile),
      ],
    );

    blocTest(
      'getUserProfile event does not trigger when AvatarBloc emits failure',
      build: () => profileBloc,
      act: (profileBloc) {
        when(() => profileRepository.getUserProfile())
            .thenAnswer((_) => Future.value(right(tAdminUserProfile)));
        when(() => profileRepository.uploadAvatar(file)).thenAnswer(
          (_) => Future.value(left(const ProfileFailure.avatarUploadFailure())),
        );
        avatarBloc.add(AvatarEvent.uploadAvatar(file));
      },
      expect: () => [],
    );

    blocTest(
      'getUserProfile event triggers when UsernameBloc emits success',
      build: () => profileBloc,
      act: (profileBloc) {
        when(() => profileRepository.getUserProfile()).thenAnswer(
          (_) => Future.value(right(tAdminUserProfile)),
        );
        when(
          () => profileRepository.updateUsername(
            firstName: "tFirstName",
            lastName: "tLastName",
          ),
        ).thenAnswer(
          (_) => Future.value(right(unit)),
        );
        usernameBloc.add(const UsernameEvent.updateUsername(
          firstName: "tFirstName",
          lastName: "tLastName",
        ));
      },
      expect: () => [const ProfileState.profileFound(tAdminUserProfile)],
    );

    blocTest(
      'getUserProfile event does not trigger when UsernameBloc emits failure',
      build: () => profileBloc,
      act: (profileBloc) {
        when(() => profileRepository.getUserProfile())
            .thenAnswer((_) => Future.value(right(tAdminUserProfile)));
        when(
          () => profileRepository.updateUsername(
            firstName: "tFirstName",
            lastName: "tLastName",
          ),
        ).thenAnswer(
          (_) => Future.value(left(const ProfileFailure.avatarUploadFailure())),
        );
        usernameBloc.add(const UsernameEvent.updateUsername(
          firstName: "tFirstName",
          lastName: "tLastName",
        ));
      },
      expect: () => [],
    );
  });
}
