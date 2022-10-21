part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class NavigateToPageEvent extends NavigationEvent {

  final String route;
  NavigateToPageEvent({required this.route});
  
}

class BrowserPopStateEvent extends NavigationEvent {

  final String route;
  BrowserPopStateEvent({required this.route});
}

