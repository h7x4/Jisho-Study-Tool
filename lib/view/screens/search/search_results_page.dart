import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/models/history/search.dart';
import 'package:jisho_study_tool/models/history/word_query.dart';
import 'package:jisho_study_tool/view/components/common/loading.dart';
import 'package:jisho_study_tool/view/components/search/search_result_body.dart';
import 'package:jisho_study_tool/services/jisho_api/jisho_search.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchTerm;
  final Future<JishoAPIResult> results;
  bool addedToDatabase = false;

  SearchResultsPage({required this.searchTerm, Key? key})
      : this.results = fetchJishoResults(searchTerm),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: results,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LoadingScreen();
          if (snapshot.hasError ||
              (snapshot.data as JishoAPIResult).data == null)
            return ErrorWidget(snapshot.error!);

          if (!this.addedToDatabase) {
            (BlocProvider.of<DatabaseBloc>(context).state as DatabaseConnected)
                .database
                .box<Search>()
                .put(Search(timestamp: DateTime.now())
                  ..wordQuery.target = WordQuery(
                    query: this.searchTerm,
                  ));
            this.addedToDatabase = true;
          }

          return SearchResultsBody(
            results: (snapshot.data as JishoAPIResult).data!,
          );
        },
      ),
    );
  }
}
