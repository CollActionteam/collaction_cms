import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';

part 'crowdaction_selected_state.dart';

@LazySingleton()
class CrowdActionSelectedCubit extends Cubit<CrowdActionSelectedState> {
  CrowdActionSelectedCubit() : super(Unknown());

  void loadCrowdActionSelected(CrowdAction crowdAction) =>
      emit(CrowdActionSelected(crowdAction: crowdAction));
}
