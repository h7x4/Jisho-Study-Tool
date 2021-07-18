import 'dart:async';

import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/models/history/kanji_result.dart';

import './kanji_event.dart';
import './kanji_state.dart';

import 'package:bloc/bloc.dart';
import 'package:jisho_study_tool/services/jisho_api/kanji_search.dart';
import 'package:jisho_study_tool/services/kanji_suggestions.dart';

export './kanji_event.dart';
export './kanji_state.dart';

class KanjiBloc extends Bloc<KanjiEvent, KanjiState> {

  DatabaseBloc _databaseBloc;

  KanjiBloc(this._databaseBloc) : super(KanjiSearch(KanjiSearchType.Initial));

  void addSearchToDB(kanji) {
    if (_databaseBloc.state is DatabaseDisconnected)
      throw DatabaseNotConnectedException;

    (_databaseBloc.state as DatabaseConnected)
      .database
      .box<KanjiResult>()
      .put(KanjiResult(
        kanji: kanji,
        timestamp: DateTime.now(),
      ));
  }

  @override
  Stream<KanjiState> mapEventToState(KanjiEvent event)
  async* {
    if (event is GetKanji) {
      
      yield KanjiSearchLoading();

      try {
        addSearchToDB(event.kanjiSearchString);
        final kanji = await fetchKanji(event.kanjiSearchString);
        if (kanji.found) yield KanjiSearchFinished(kanji: kanji);
        else yield KanjiSearchError('Something went wrong');
      } on Exception {
        yield KanjiSearchError('Something went wrong');
      }
    } else if (event is GetKanjiSuggestions) {
      
      final suggestions = kanjiSuggestions(event.searchString);
      yield KanjiSearchKeyboard(KanjiSearchType.Keyboard, suggestions);

    } else if (event is ReturnToInitialState) {
      yield KanjiSearch(KanjiSearchType.Initial);
    }
  }
}
