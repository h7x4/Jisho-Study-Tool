import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/search/search_bloc.dart';
import 'package:jisho_study_tool/view/components/search/search_bar.dart';
import 'package:jisho_study_tool/view/screens/loading.dart';
import 'package:jisho_study_tool/view/screens/search/results.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SearchInitial)
          return _InitialView();
        else if (state is SearchLoading)
          return LoadingScreen();
        else if (state is SearchFinished) {
          return SearchResults(results: state.results);
        }
        throw 'No such event found';
      },
    );
  }
}

class _InitialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SearchBar(),
    ]);
  }
}
