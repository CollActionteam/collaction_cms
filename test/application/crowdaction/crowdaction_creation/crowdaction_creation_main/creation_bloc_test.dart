import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/main/crowdaction_creation_bloc.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_creation/i_create_crowdation_repository.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_fracture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import '../../../../test_utilities.dart';
import 'creation_bloc_utils.dart';

void main() {
  final createCrowdActionRepository = MockCreateCrowdActionRepository();
  group("Testing CrowdActionCreationBloc", () {
    late MediatorBloc mediatorBloc;
    late CrowdActionCreationBloc crowdActionCreationBloc;

    setUp(() {
      mediatorBloc = MediatorBloc();
      crowdActionCreationBloc =
          CrowdActionCreationBloc(mediatorBloc, createCrowdActionRepository);
    });

    {
      when(() => createCrowdActionRepository.createCrowdAction(
              tCrowdActionInfo, tCommitmentsList, tImages))
          .thenAnswer((invocation) => Future.value(right("AbacabId")));

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
          const CrowdActionCreationState.loading(),
          const CrowdActionCreationState.crowdActionCreated("AbacabId")
        ],
      );
    }

    blocTest(
      "Testing bloc to bloc communication not completed",
      build: () => crowdActionCreationBloc,
      act: (bloc) {
        mediatorBloc.add(MediatorEvent.loadCrowdActionInfo(tCrowdActionInfo));
        mediatorBloc.add(
            const MediatorEvent.loadCrowdActionCommitments(tCommitmentsList));
      },
      expect: () => [],
    );
  });
}
