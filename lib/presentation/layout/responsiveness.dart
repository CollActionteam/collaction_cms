import 'package:flutter/material.dart';

const int largeScreenSize = 1366;
const int mediumScreenSize = 768;

/// [ResponsiveWidget] is used to define which
/// widget to show based on defined breakpoints,
/// that are dynamically chosen based on the width
/// of the screen in pixels
///
/// [largeScreen] The widget to display if width > 1366px
/// [mediumScreen] The widget to display if width < 1366px
/// and width > 768px
/// [smallScreen] The widget to display if width < 768px
///
/// [largeScreen] Is required, and is used as fallback in case
/// either or both [mediumScreen] and [smallScreen] is null
class ResponsiveWidget extends StatelessWidget {
  /// Widget to display if screen width is more than 1366px
  final Widget largeScreen;

  /// Widget to display if screen width is more than 768px
  /// and less than 1366px
  final Widget? mediumScreen;

  /// Widget to display if screen width is less than 768px
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  /// Returns true if width of current renderbox is
  /// less than [mediumScreenSize] which is 768 pixels
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < mediumScreenSize;
  }

  // Might be useful in the future
  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumScreenSize &&
        MediaQuery.of(context).size.width < largeScreenSize;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > largeScreenSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= largeScreenSize) {
          return largeScreen;
        } else if (constraints.maxWidth < largeScreenSize &&
            constraints.maxWidth >= mediumScreenSize) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
