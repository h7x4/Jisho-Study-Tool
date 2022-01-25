import 'package:flutter/material.dart';

import '../../components/common/loading.dart';
import '../../components/kanji/kanji_result_body.dart';
import '../../components/search/search_result_body.dart';
import '../../models/history/search.dart';
import '../../services/jisho_api/jisho_search.dart';
import '../../services/jisho_api/kanji_search.dart';

class ResultPage extends StatefulWidget {
  final String searchTerm;
  final bool isKanji;

  const ResultPage({
    Key? key,
    required this.searchTerm,
    required this.isKanji,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool addedToDatabase = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: widget.isKanji
            ? fetchKanji(widget.searchTerm)
            : fetchJishoResults(widget.searchTerm),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LoadingScreen();
          if (snapshot.hasError) return ErrorWidget(snapshot.error!);

          if (!addedToDatabase) {
            addSearchToDatabase(
              searchTerm: widget.searchTerm,
              isKanji: widget.isKanji,
            );
            addedToDatabase = true;
          }

          return widget.isKanji
              ? KanjiResultBody(result: snapshot.data! as KanjiResult)
              : SearchResultsBody(
                  results: (snapshot.data! as JishoAPIResult).data!,
                );
        },
      ),
    );
  }
}
