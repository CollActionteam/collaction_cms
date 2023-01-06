part of 'pagination_cubit.dart';

abstract class PaginationState extends Equatable {}

class Unknown extends PaginationState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PaginationLoaded extends PaginationState {

  PaginationLoaded({
    required this.page,
    required this.totalPages,
    required this.pageSize,
    this.status
  });

  final int page;
  final int totalPages;
  final Status? status;
  final int pageSize;

  @override
  // TODO: implement props
  List<Object?> get props => [page, totalPages, status, pageSize];
}