import 'package:dartz/dartz.dart';

import 'crowdaction_failures.dart';
import 'pagination/paginated_crowdactions.dart';

abstract class ICrowdActionRepository {
  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdActions(
    int page,
    int pageSize,
    String? status,
  );

  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdAction(
    String? slug,
    String? id,
  );
}
