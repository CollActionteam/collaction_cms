import 'package:equatable/equatable.dart';

class PaginationInfo extends Equatable {

  const PaginationInfo({
    this.totalItems,
    required this.totalPages,
    required this.page,
    this.pageSize,
    
  });

  final int? totalItems;
  final int totalPages;
  final int page;
  final int? pageSize;

  @override
  // TODO: implement props
  List<Object?> get props => [totalItems, totalPages, page, pageSize];
}

