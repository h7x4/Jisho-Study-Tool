import 'package:flutter/material.dart';

import '../../components/common/loading.dart';
import '../../components/kanji/kanji_result_body.dart';
import '../../models/history/kanji_query.dart';
import '../../models/history/search.dart';
import '../../services/jisho_api/kanji_search.dart';

class KanjiResultPage extends StatefulWidget {
  final String kanjiSearchTerm;

  const KanjiResultPage({
    Key? key,
    required this.kanjiSearchTerm,
  }) : super(key: key);

  @override
  _KanjiResultPageState createState() => _KanjiResultPageState();
}

class _KanjiResultPageState extends State<KanjiResultPage> {
  bool addedToDatabase = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<KanjiResult>(
        future: fetchKanji(widget.kanjiSearchTerm),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LoadingScreen();
          if (snapshot.hasError) return ErrorWidget(snapshot.error!);

          if (!addedToDatabase) {
            Search.store.add(
              GetIt.instance.get<Database>(),
              Search.fromKanjiQuery(
                timestamp: DateTime.now(),
                kanjiQuery: KanjiQuery(kanji: widget.kanjiSearchTerm),
              ).toJson(),
            );
            addedToDatabase = true;
          }

          return KanjiResultBody(result: snapshot.data!);
        },
      ),
    );
  }
}
