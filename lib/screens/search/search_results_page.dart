import 'package:flutter/material.dart';

import '../../components/common/loading.dart';
import '../../components/search/search_result_body.dart';
import '../../models/history/search.dart';
import '../../models/history/word_query.dart';
import '../../services/jisho_api/jisho_search.dart';

// TODO: merge with KanjiResultPage
class SearchResultsPage extends StatefulWidget {
  final String searchTerm;

  const SearchResultsPage({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  bool addedToDatabase = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<JishoAPIResult>(
        future: fetchJishoResults(widget.searchTerm),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LoadingScreen();
          if (snapshot.hasError || snapshot.data!.data == null)
            return ErrorWidget(snapshot.error!);

          if (!addedToDatabase) {
            Search.store.add(
              GetIt.instance.get<Database>(),
              Search.fromWordQuery(
                timestamp: DateTime.now(),
                wordQuery: WordQuery(query: widget.searchTerm),
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
