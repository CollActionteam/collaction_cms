import 'package:collaction_cms/application/crowdaction/crowdaction_selected/crowdaction_selected_cubit.dart';
import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_view/commitments_panel.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_view/header.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_view/fields_panels.dart';
import 'package:collaction_cms/presentation/go_routing/routes.dart';
import 'package:collaction_cms/presentation/shared/composition/text_composition.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:collaction_cms/presentation/crowdactions/crowdaction_view/base_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          var crowdAction = state.crowdAction;
          print(crowdAction.images.banner);
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
                          BasePanel(
                            crowdAction: crowdAction,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 70),
                    Expanded(
                        child: CommitmentsPanel(
                      commitments: crowdAction.commitments,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: kAccentColor,
            ),
          );
        }
      },
    );
  }
}
