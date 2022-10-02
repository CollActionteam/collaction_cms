import 'package:collaction_admin/presentation/navigation/widgets/menu.dart';
import 'package:collaction_admin/presentation/theme/constants.dart';
import 'package:flutter/material.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: 290.0,
      color: kPrimaryColor,
      child: const Menu(),
    );
  }
}