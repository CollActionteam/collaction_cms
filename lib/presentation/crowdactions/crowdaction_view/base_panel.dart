import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/ui/crowdaction_view/crowdaction_view_info_cubit.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../shared/options/selection_option.dart';
import '../../theme/constants.dart';
import 'fields_panels.dart';

class BasePanel extends StatefulWidget {
  const BasePanel({
    super.key,
    required this.crowdAction,
  });

  final CrowdAction crowdAction;

  @override
  State<BasePanel> createState() => _BasePanelState();
}

class _BasePanelState extends State<BasePanel> {
  InfoSelectionOption _infoSelectionOption = InfoSelectionOption.info;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrowdActionViewInfoCubit>(
      create: (context) => CrowdActionViewInfoCubit(),
      child: BlocConsumer<CrowdActionViewInfoCubit, CrowdActionViewInfoState>(
        listener: (context, state) {
          state.map(
            info: ((value) => _infoSelectionOption = InfoSelectionOption.info),
            dates: ((value) =>
                _infoSelectionOption = InfoSelectionOption.dates),
            timestamps: ((value) =>
                _infoSelectionOption = InfoSelectionOption.timestamps),
            images: ((value) =>
                _infoSelectionOption = InfoSelectionOption.images),
          );
        },
        builder: (context, state) {
          final crowdAction = widget.crowdAction;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const SelectableText(
                "Fields",
                style: CollactionTextStyles.subtitleStyleCMS,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SelectionOption(
                    isSelected:
                        _infoSelectionOption == InfoSelectionOption.info,
                    iconData: Icons.info_outline_rounded,
                    text: "Info",
                    callback: () =>
                        BlocProvider.of<CrowdActionViewInfoCubit>(context)
                            .loadInfoSelectionOption(InfoSelectionOption.info),
                  ),
                  const SizedBox(width: 20),
                  SelectionOption(
                    isSelected:
                        _infoSelectionOption == InfoSelectionOption.dates,
                    iconData: Icons.calendar_today_outlined,
                    text: "Dates",
                    callback: () =>
                        BlocProvider.of<CrowdActionViewInfoCubit>(context)
                            .loadInfoSelectionOption(
                      InfoSelectionOption.dates,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SelectionOption(
                    isSelected:
                        _infoSelectionOption == InfoSelectionOption.timestamps,
                    iconData: Icons.timer_outlined,
                    text: "Timestamps",
                    callback: () =>
                        BlocProvider.of<CrowdActionViewInfoCubit>(context)
                            .loadInfoSelectionOption(
                      InfoSelectionOption.timestamps,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SelectionOption(
                    isSelected:
                        _infoSelectionOption == InfoSelectionOption.images,
                    iconData: Icons.image_outlined,
                    text: "Images",
                    callback: () =>
                        BlocProvider.of<CrowdActionViewInfoCubit>(context)
                            .loadInfoSelectionOption(
                      InfoSelectionOption.images,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
              const Divider(thickness: 1, color: Color(0xFFE7E7E7)),
              state.map(
                info: (value) {
                  return InfoPanel(
                    location: crowdAction.location,
                    category: crowdAction.category,
                    subcategory: crowdAction.subcategory ?? "--",
                    description: crowdAction.description,
                  );
                },
                dates: (value) {
                  return DatesPanel(
                    startAt: crowdAction.startAt,
                    endAt: crowdAction.endAt,
                    joinEndAt: crowdAction.joinEndAt,
                  );
                },
                timestamps: (value) {
                  return TimestampPanel(
                    createdAt: crowdAction.createdAt,
                    updatedAt: crowdAction.updatedAt,
                  );
                },
                images: (value) {
                  return ImagesPanel(
                    banner: crowdAction.images.banner,
                    card: crowdAction.images.card,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
