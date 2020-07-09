import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'kanji_event.dart';
part 'kanji_state.dart';

class KanjiBloc extends Bloc<KanjiEvent, KanjiState> {
  KanjiBloc() : super(KanjiSearchInitial());

  @override
  Stream<KanjiState> mapEventToState(
    KanjiEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
