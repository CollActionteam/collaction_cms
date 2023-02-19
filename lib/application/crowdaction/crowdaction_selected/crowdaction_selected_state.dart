part of 'crowdaction_selected_cubit.dart';

abstract class CrowdActionSelectedState extends Equatable {}

class Unknown extends CrowdActionSelectedState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CrowdActionSelected extends CrowdActionSelectedState {

  CrowdActionSelected({
    required this.crowdAction
  });

  final CrowdAction crowdAction;

  @override
  // TODO: implement props
  List<Object?> get props => [crowdAction];
}