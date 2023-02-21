import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_view_info_state.dart';
part 'crowdaction_view_info_cubit.freezed.dart';

enum InfoSelectionOption {info, dates, timestamps, images}

class CrowdActionViewInfoCubit extends Cubit<CrowdActionViewInfoState> {
  CrowdActionViewInfoCubit() : super(const CrowdActionViewInfoState.info());

  void loadInfoSelectionOption(InfoSelectionOption infoSelectionOption) {
    if(infoSelectionOption == InfoSelectionOption.info) {
      emit(const CrowdActionViewInfoState.info());
    }

    if(infoSelectionOption == InfoSelectionOption.dates) {
      emit(const CrowdActionViewInfoState.dates());
    }

    if(infoSelectionOption == InfoSelectionOption.timestamps) {
      emit(const CrowdActionViewInfoState.timestamps());
    }

    if(infoSelectionOption == InfoSelectionOption.images) {
      emit(const CrowdActionViewInfoState.images());
    }
  }
}
