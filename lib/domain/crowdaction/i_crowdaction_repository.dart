import 'package:collaction_cms/domain/crowdaction/pagination/paginated_crowdactions.dart';
import 'package:dartz/dartz.dart';

import 'crowdaction.dart';
import 'crowdaction_failures.dart';


abstract class ICrowdActionRepository {
  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdActions(
    int page,
    int pageSize,
    Status? status
  );
 
  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdAction(
    String? slug,
    String? id
  );
}

