import 'package:flutter/material.dart';

import '../../../bloc/database/database_bloc.dart';
import '../../../models/history/search.dart';
import '../../../models/history/word_query.dart';
import '../../../services/jisho_api/jisho_search.dart';
import '../../components/common/loading.dart';
import '../../components/search/search_result_body.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchTerm;
  final Future<JishoAPIResult> results;
  bool addedToDatabase = false;

  SearchResultsPage({required this.searchTerm, Key? key})
      : results = fetchJishoResults(searchTerm),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<JishoAPIResult>(
        future: results,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LoadingScreen();
          if (snapshot.hasError || snapshot.data!.data == null)
            return ErrorWidget(snapshot.error!);

          if (!addedToDatabase) {
            (BlocProvider.of<DatabaseBloc>(context).state as DatabaseConnected)
                .database
                .box<Search>()
                .put(
                  Search(timestamp: DateTime.now())
                    ..wordQuery.target = WordQuery(
                      query: searchTerm,
                    ),
                );
            addedToDatabase = true;
          }

          return SearchResultsBody(
            results: snapshot.data!.data!,
          );
        },
      ),
    );
  }
}
