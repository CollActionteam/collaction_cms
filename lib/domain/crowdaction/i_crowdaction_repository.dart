import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'crowdaction.dart';
import 'crowdaction_failures.dart';

abstract class ICrowdActionRepository {
  Future<Either<CrowdActionFailure, List<CrowdAction>>> getCrowdActions(
    int page,
    int pageSize,
    Status? status
  );
}

