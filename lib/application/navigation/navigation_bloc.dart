import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:collaction_admin/infrastructure/core/injection.dart';
import 'package:injectable/injectable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';


@lazySingleton
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<NavigateToPageEvent>((event, emit) {
      emit(state.copyWith(route: event.route));
    });
  }
}

