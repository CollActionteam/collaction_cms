part of 'navigation_bloc.dart';

class NavigationState {
  NavigationState({this.route = "/"});

  final String route;

  NavigationState copyWith({String? route}) {
    return NavigationState(
      route: route!,
    );
  }
}
