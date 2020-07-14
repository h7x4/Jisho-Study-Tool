import 'dart:async';

import './kanji_event.dart';
import './kanji_state.dart';

import 'package:bloc/bloc.dart';
import 'package:jisho_study_tool/services/kanji_search.dart';

export './kanji_event.dart';
export './kanji_state.dart';

class KanjiBloc extends Bloc<KanjiEvent, KanjiState> {

  KanjiBloc() : super(KanjiSearchInitial());

  @override
  Stream<KanjiState> mapEventToState(
    KanjiEvent event,
  ) async* {
    if (event is GetKanji) {
      
      yield KanjiSearchLoading();

      try {
        final _kanji = await fetchKanji(event.kanjiSearchString);
        yield KanjiSearchFinished(kanji: _kanji);
      } on Exception {
        yield KanjiSearchError('Something went wrong');
      }

    } else if (event is ReturnToInitialState) {
      yield KanjiSearchInitial();
    }
  }
}
