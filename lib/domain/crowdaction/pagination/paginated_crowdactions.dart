import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/pagination/pagination.dart';
import 'package:collaction_cms/presentation/crowdactions/pagination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'paginated_crowdactions.freezed.dart';

@freezed
class PaginatedCrowdActions with _$PaginatedCrowdActions {

  factory PaginatedCrowdActions({
    required List<CrowdAction> crowdActions,
    required PaginationInfo paginationInfo
  }) = _PaginatedCrowdActions;
}
