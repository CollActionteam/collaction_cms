import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/main/crowdaction_creation_bloc.dart';
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
    late CrowdActionCreationBloc crowdActionCreationBloc;

    setUp(() {
      crowdActionCreationBloc =
          CrowdActionCreationBloc(createCrowdActionRepository);
    });

    {
      when(() => createCrowdActionRepository.createCrowdAction(
              tCrowdActionInfo, tCommitmentsList, tImages))
          .thenAnswer((invocation) => Future.value(right("AbacabId")));

      blocTest(
        "Testing bloc to bloc communication triggers",
        build: () => crowdActionCreationBloc,
        act: (bloc) {
          bloc.add(CrowdActionCreationEvent.createCrowdAction(
              tCrowdActionInfo, tCommitmentsList, tImages));
        },
        expect: () => [
          const CrowdActionCreationState.loading(),
          const CrowdActionCreationState.crowdActionCreated("AbacabId")
        ],
      );
    }
  });
}
