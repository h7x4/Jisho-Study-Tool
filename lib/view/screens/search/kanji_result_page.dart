import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import '../../../models/history/kanji_query.dart';
import '../../../models/history/search.dart';
import '../../../services/jisho_api/kanji_search.dart';
import '../../components/common/loading.dart';
import '../../components/kanji/kanji_result_body.dart';

class KanjiResultPage extends StatelessWidget {
  final String kanjiSearchTerm;
  bool addedToDatabase = false;

  KanjiResultPage({required this.kanjiSearchTerm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<KanjiResult>(
        future: fetchKanji(kanjiSearchTerm),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LoadingScreen();
          if (snapshot.hasError) return ErrorWidget(snapshot.error!);

          if (!addedToDatabase) {
            Search.store.add(
              GetIt.instance.get<Database>(),
              Search.fromKanjiQuery(
                timestamp: DateTime.now(),
                kanjiQuery: KanjiQuery(kanji: kanjiSearchTerm),
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
