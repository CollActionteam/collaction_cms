import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/crowdaction_selected/crowdaction_selected_cubit.dart';
import '../../theme/constants.dart';
import 'base_panel.dart';
import 'commitments_panel.dart';
import 'header.dart';

class CrowdActionPage extends StatelessWidget {
  const CrowdActionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrowdActionSelectedCubit, CrowdActionSelectedState>(
      builder: (context, state) {
        if (state is Unknown) {
          return const Center(
            child: CircularProgressIndicator(color: kAccentColor),
          );
        }

        if (state is CrowdActionSelected) {
          final crowdAction = state.crowdAction;

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CrowdActionHeader(
                    title: crowdAction.title,
                    joinStatus: crowdAction.joinStatus,
                    status: crowdAction.status,
                    participationCount: crowdAction.participantCount),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          BasePanel(crowdAction: crowdAction),
                        ],
                      ),
                    ),
                    const SizedBox(width: 70),
                    Expanded(
                      child: CommitmentsPanel(
                        commitments: crowdAction.commitments,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20)
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: kAccentColor,
          ),
        );
      },
    );
  }
}
