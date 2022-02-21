import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

@injectable
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<NavigateToPageEvent>((event, emit) {
      emit(state.copyWith(page: event.page));
    });
  }
}
