import 'package:collaction_admin/application/navigation/navigation_bloc.dart';
import 'package:collaction_admin/presentation/navigation/widgets/navigation_item.dart';
import 'package:collaction_admin/presentation/navigation/widgets/special_navigation_item.dart';
import 'package:collaction_admin/presentation/routing/routes.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<NavigationBloc>(context),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 75,
                child: Image.network(
                  'https://www.collaction.org/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Flogo-green-small.88b18977.png&w=128&q=75',
                ),
              ),
              const Divider(height: 0, color: kBorderColor),
              const SizedBox(height: 35.0),
              SpecialNavigationItem(
                icon: Icons.add_circle_outline,
                label: 'Invite Admin',
                onTap: () => BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToPageEvent(page: 'AdminModeration')),
              ),
              const SizedBox(height: 35.0),
              NavigationItem(
                key: GlobalKey<State>(),
                icon: Icons.devices_other_outlined,
                isActive: state.page == dashboardPageRoute,
                label: 'Dashboard',
                onTap: () => BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToPageEvent(page: 'Dashboard')),
              ),
              const SizedBox(height: 10),
              NavigationItem(
                key: GlobalKey<State>(),
                icon: Icons.dns_outlined,
                isActive: state.page == crowdActionPageRoute,
                label: 'CrowdActions',
                onTap: () => BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToPageEvent(page: 'CrowdActions')),
              ),
              const SizedBox(height: 10),
              NavigationItem(
                key: GlobalKey<State>(),
                icon: Icons.insert_comment_outlined,
                isActive: state.page == moderationQueuePageRoute,
                label: 'Moderation Queue',
                onTap: () => BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToPageEvent(page: 'ModerationQueue')),
              ),
            ],
          );
        },
      ),
    );
  }
}
