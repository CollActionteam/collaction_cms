import 'dart:typed_data';

import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';

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
