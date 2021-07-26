import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jisho_study_tool/models/history/search_string.dart';
import 'package:meta/meta.dart';

import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/services/jisho_api/jisho_search.dart';
import 'package:unofficial_jisho_api/parser.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  DatabaseBloc _databaseBloc;

  SearchBloc(this._databaseBloc) : super(SearchInitial());

  void addSearchToDB(searchString) {
    if (_databaseBloc.state is DatabaseDisconnected)
      throw DatabaseNotConnectedException;

    (_databaseBloc.state as DatabaseConnected)
      .database
      .box<SearchString>()
      .put(SearchString(
        query: searchString,
        timestamp: DateTime.now(),
      ));
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchResults) {
      yield SearchLoading();

      try {
        addSearchToDB(event.searchString);
        final searchResults = await fetchJishoResults(event.searchString);
        if (searchResults.meta.status == 200) yield SearchFinished(searchResults.data!);
      } on Exception {
        yield SearchError('Something went wrong');
      }
    } else if (event is ReturnToInitialState) {
      yield SearchInitial();
    }
  }
}
