import 'dart:typed_data';

import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:collaction_cms/domain/auth/i_auth_client_repository.dart';
import 'package:collaction_cms/domain/profile/i_profile_repository.dart';
import 'package:collaction_cms/domain/profile/profile.dart';
import 'package:collaction_cms/domain/profile/user_profile.dart';
import 'package:collaction_cms/domain/user/user.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthClientRepository extends Mock implements IAuthClientRepository {}

class MockProfileRepository extends Mock implements IProfileRepository {}

final tCrowdActionInfo = CrowdActionInfo(
    title: "tTitle",
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 10)),
    country: tLocation,
    description: "tDescription",
    category: "tCategory");

final tCrowdaction = CrowdAction(
  id: 'tID',
  title: 'tTitle',
  description: 'tDescription',
  category: 'tCategory',
  location: tLocation,
  commitments: tCommitmentsList,
  startAt: DateTime.now(),
  joinEndAt: DateTime.now().add(const Duration(days: 5)),
  endAt: DateTime.now().add(const Duration(days: 10)),
  images: const Images(card: 'tCard', banner: 'tBanner'),
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  participantCount: 10,
  status: Status.ended,
  joinStatus: JoinStatus.closed,
  password: 'testPwd',
);

const tCommitment1 = Commitment(
  id: "0001",
  tags: ["one", "two", "three"],
  iconId: 'no-beef',
  label: 'tLabel',
  description: 'tDescription',
  points: 0,
  blocks: [],
);

const tCommitment2 = Commitment(
  id: "0002",
  tags: ["one", "two", "three"],
  iconId: 'no-beef',
  label: 'tLabel',
  description: 'tDescription',
  points: 0,
  blocks: [],
);

const tCommitment3 = Commitment(
  id: "0003",
  tags: ["one", "two", "three"],
  iconId: 'no-beef',
  label: 'tLabel',
  description: 'tDescription',
  points: 0,
  blocks: [],
);

final tImages = CrowdActionImages(card: Uint8List(5), banner: Uint8List(10));

const tCommitmentsList = [tCommitment1, tCommitment2, tCommitment3];

const Location tLocation = Location(code: 'tCode', name: 'tName');

final List<String> tCommitment = ['tCommitment'];

const tUser = User(
  id: 'tId',
  getIdToken: User.getAnonymousIdToken,
);

const tProfile = Profile(
  userId: 'tId',
  firstName: 'tFirstName',
  lastName: 'tLastName',
  avatar: 'tAvatar',
);

const tAdminUserProfile = UserProfile(
  user: tUser,
  profile: tProfile,
  role: Role.admin,
);

const tModeratorUserProfile = UserProfile(
  user: tUser,
  profile: tProfile,
  role: Role.moderator,
);
