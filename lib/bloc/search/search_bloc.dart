import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:jisho_study_tool/services/jisho_api/jisho_search.dart';
import 'package:unofficial_jisho_api/parser.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchResults) {
      yield SearchLoading();

      try {
        final _searchResults = await fetchJishoResults(event.searchString);
        if (_searchResults.meta.status == 200) yield SearchFinished(_searchResults.data);
      } on Exception {
        yield SearchError('Something went wrong');
      }
    } else if (event is ReturnToInitialState) {
      yield SearchInitial();
    }
  }
}
