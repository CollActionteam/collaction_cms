import 'package:collaction_cms/presentation/layout/responsiveness.dart';
import 'package:collaction_cms/presentation/layout/screen_definitions/large_screen.dart';
import 'package:collaction_cms/presentation/layout/screen_definitions/small_screen.dart';
import 'package:collaction_cms/presentation/navigation/widgets/menu.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';


class PageLayout extends StatefulWidget {
  const PageLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  late GlobalKey<ScaffoldState> scaffoldKey;
  late GlobalKey<NavigatorState> navigatorKey;


  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(
        backgroundColor: kPrimaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Menu(),
        ),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(
            scaffoldKey: scaffoldKey,
            navigatorKey: navigatorKey,
            child: widget.child),
        smallScreen: SmallScreen(
            scaffoldKey: scaffoldKey,
            navigatorKey: navigatorKey,
            child: widget.child),
      ),
    );
  }
}
