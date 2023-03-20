import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/crowdaction_creation_failures.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_images.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_info.dart';
import 'package:dartz/dartz.dart';

abstract class ICreateCrowdActionRepository {
  Future<Either<CrowdActionCreationFailure, String>> createCrowdAction(
      CrowdActionInfo crowdActionInfo,
      List<Commitment> commitments,
      CrowdActionImages crowdActionImages);

  Future<Either<CrowdActionCreationFailure, String>> updateCrowdActionImages(
    CrowdActionImages crowdActionImages,
    String tokenId,
    String id,
  );
}
