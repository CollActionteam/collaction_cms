import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';

part 'pagination_state.dart';

@LazySingleton()
class PaginationCubit extends Cubit<PaginationState> {
  PaginationCubit() : super(Unknown());

  void loadPagination(int page, int totalPages, Status? status, int pageSize) =>
      emit(
        PaginationLoaded(
          page: page,
          totalPages: totalPages,
          status: status,
          pageSize: pageSize,
        ),
      );
}
