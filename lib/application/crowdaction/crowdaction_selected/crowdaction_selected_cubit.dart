import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'crowdaction_selected_state.dart';

@LazySingleton()
class CrowdActionSelectedCubit extends Cubit<CrowdActionSelectedState> {
  CrowdActionSelectedCubit() : super(Unknown());

  void loadCrowdActionSelected(CrowdAction crowdAction) =>
      emit(CrowdActionSelected(crowdAction: crowdAction));
}
