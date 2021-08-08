import 'package:bloc/bloc.dart';

import './navigation_event.dart';
import './navigation_state.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

export './navigation_event.dart';
export './navigation_state.dart'; 

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {

  NavigationBloc() : super(NavigationPage(0));

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is ChangePage)
      yield NavigationPage(event.pageNum);
  }
}