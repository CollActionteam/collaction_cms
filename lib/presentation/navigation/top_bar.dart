import 'package:collaction_cms/application/user/profile/profile_bloc.dart';
import 'package:collaction_cms/domain/profile/user_profile.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isSmallScreen;

  const TopBar({
    super.key,
    this.isSmallScreen = false,
    required this.scaffoldKey,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late UserProfile? userProfile;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      state.maybeMap(
        profileFound: (value) => userProfile = value.userProfile,
        orElse: () => userProfile = null,
      );
      return Column(
        children: [
          SizedBox(
            height: 75.0,
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kBorderColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: !widget.isSmallScreen
                      ? const Icon(
                          Icons.devices_other_outlined,
                          color: kNavItemActiveColor,
                        )
                      : IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () =>
                              widget.scaffoldKey.currentState?.openDrawer(),
                        ),
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Text(userProfile?.profile.firstName ?? 'User'),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 0, color: kBorderColor),
        ],
      );
    });
  }
}
