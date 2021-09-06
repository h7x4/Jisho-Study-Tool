import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/models/history/kanji_query.dart';
import 'package:jisho_study_tool/models/history/search.dart';
import 'package:jisho_study_tool/view/components/common/loading.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_result_body.dart';
import 'package:jisho_study_tool/services/jisho_api/kanji_search.dart';

class KanjiResultPage extends StatelessWidget {
  final String kanjiSearchTerm;
  bool addedToDatabase = false;

  KanjiResultPage({required this.kanjiSearchTerm, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: fetchKanji(this.kanjiSearchTerm),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LoadingScreen();
          if (snapshot.hasError) return ErrorWidget(snapshot.error!);

          if (!this.addedToDatabase) {
            (BlocProvider.of<DatabaseBloc>(context).state as DatabaseConnected)
                .database
                .box<Search>()
                .put(Search(timestamp: DateTime.now())
                  ..kanjiQuery.target = KanjiQuery(
                    kanji: this.kanjiSearchTerm,
                  ));
            this.addedToDatabase = true;
          }

          return KanjiResultBody(result: (snapshot.data as KanjiResult));
        },
      ),
    );
  }
}
