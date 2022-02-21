part of 'navigation_bloc.dart';

class NavigationState {
  final String page;
  NavigationState({
    this.page = 'Dashboard',
  });

  NavigationState copyWith({String? page}) {
    return NavigationState(
      page: page ?? this.page,
    );
  }
}
