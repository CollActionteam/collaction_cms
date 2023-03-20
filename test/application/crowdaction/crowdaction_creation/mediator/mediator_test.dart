import 'package:collaction_cms/application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_fracture.dart';
import '../../../../test_utilities.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group("Testing mediator bloc", () {
    final mediator = MediatorBloc();
    test("Testing initial state", () {
      expect(
          mediator.state,
          MediatorState.initial(
            CrowdActionFractured(),
          ));
    });
  });

  blocTest("Testing mediator events",
      build: () => MediatorBloc(),
      act: (MediatorBloc bloc) {
        bloc.add(MediatorEvent.loadCrowdActionInfo(tCrowdActionInfo));
        bloc.add(
            const MediatorEvent.loadCrowdActionCommitments(tCommitmentsList));
        bloc.add(MediatorEvent.loadCrowdActionImages(tImages));
      },
      expect: () => [
            MediatorState.loaded(CrowdActionFractured(
              crowdActionInfo: tCrowdActionInfo,
            )),
            MediatorState.loaded(CrowdActionFractured(
                crowdActionInfo: tCrowdActionInfo,
                crowdActionCommitments: tCommitmentsList)),
            MediatorState.loaded(CrowdActionFractured(
              crowdActionInfo: tCrowdActionInfo,
              crowdActionCommitments: tCommitmentsList,
              crowdActionImages: tImages,
            )),
          ]);
}
