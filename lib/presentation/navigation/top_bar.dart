import 'package:collaction_admin/application/authentication/authentication_bloc.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isSmallScreen;
  const TopBar({
    Key? key,
    this.isSmallScreen = false,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: !isSmallScreen
                    ? const Icon(
                        Icons.devices_other_outlined,
                        color: kNavItemActiveColor,
                      )
                    : IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      ),
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  Text(
                    BlocProvider.of<AuthenticationBloc>(context)
                        .authedUser!
                        .displayName!,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 0, color: kBorderColor),
      ],
    );
  }
}
