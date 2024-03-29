part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class NavigateToPageEvent extends NavigationEvent {
  final String page;
  NavigateToPageEvent({required this.page});
}
