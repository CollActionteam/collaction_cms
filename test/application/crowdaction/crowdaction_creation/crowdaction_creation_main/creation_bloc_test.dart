import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/main/crowdaction_creation_bloc.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_fracture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities.dart';

void main() {
  group("Testing CrowdActionCreationBloc", () {
    late MediatorBloc mediatorBloc;
    late CrowdActionCreationBloc crowdActionCreationBloc;

    setUp(() {
      mediatorBloc = MediatorBloc();
      // mediatorStreamController = StreamController<MediatorState>();
      crowdActionCreationBloc = CrowdActionCreationBloc(mediatorBloc);
    });

    blocTest(
      "Testing bloc to bloc communication triggers",
      build: () => crowdActionCreationBloc,
      act: (bloc) {
        mediatorBloc.add(MediatorEvent.loadCrowdActionInfo(tCrowdActionInfo));
        mediatorBloc.add(
            const MediatorEvent.loadCrowdActionCommitments(tCommitmentsList));
        mediatorBloc.add(MediatorEvent.loadCrowdActionImages(tImages));
      },
      expect: () => [
        CrowdActionCreationState.crowdActionCreated(CrowdActionFractured(
            crowdActionInfo: tCrowdActionInfo,
            crowdActionCommitments: tCommitmentsList,
            crowdActionImages: tImages))
      ],
    );
  });
}
