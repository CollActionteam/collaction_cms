import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/commitments/commitments_bloc.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/main/crowdaction_creation_bloc.dart';
import 'package:collaction_cms/application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction_utility/crowdaction_fracture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities.dart';

void main() {
  group("Testing Commitments bloc", () {
    test("Test initial state", () {
      final commitmentsBloc = CommitmentsBloc();
      expect(commitmentsBloc.state,
          const CommitmentsState.initial(<Commitment>[]));
    });

    blocTest("Testing commitments bloc events",
        build: () => CommitmentsBloc(),
        act: (bloc) {
          bloc.add(const CommitmentsEvent.addCommitment(tCommitment1));
          bloc.add(const CommitmentsEvent.addCommitment(tCommitment2));
          bloc.add(const CommitmentsEvent.addCommitment(tCommitment3));
          bloc.add(const CommitmentsEvent.removeCommitment("0002"));
          bloc.add(CommitmentsEvent.editCommitment(
              tCommitment3.copyWith(description: "Abacab")));
        },
        expect: () => [
              const CommitmentsState.commitmentsSet(<Commitment>[tCommitment1]),
              const CommitmentsState.commitmentsSet(
                  <Commitment>[tCommitment1, tCommitment2]),
              const CommitmentsState.commitmentsSet(
                  <Commitment>[tCommitment1, tCommitment2, tCommitment3]),
              const CommitmentsState.commitmentsSet(
                  <Commitment>[tCommitment1, tCommitment3]),
              CommitmentsState.commitmentsSet(<Commitment>[
                tCommitment1,
                tCommitment3.copyWith(description: "Abacab")
              ])
            ]);
  });
}
