import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

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
          if (!snapshot.hasData) return const LoadingScreen();
          if (snapshot.hasError || snapshot.data!.data == null)
            return ErrorWidget(snapshot.error!);

          if (!addedToDatabase) {
            Search.store.add(
              GetIt.instance.get<Database>(),
              Search.fromWordQuery(
                timestamp: DateTime.now(),
                wordQuery: WordQuery(query: searchTerm),
              ).toJson(),
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
