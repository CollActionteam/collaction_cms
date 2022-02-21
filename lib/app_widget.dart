import 'package:collaction_admin/presentation/layout/page_layout.dart';
import 'package:collaction_admin/presentation/theme/theme.dart';

import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdminCMS',
      theme: appTheme,
      home: const PageLayout(),
    );
  }
}
