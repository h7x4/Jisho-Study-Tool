import 'package:flutter/material.dart';
import './kanji_search.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import 'package:jisho_study_tool/components/kanji/kanji_search_page.dart';

Widget searchForKanji(String kanji) {
  return FutureBuilder(
    future: fetchKanji(kanji),
    builder: (BuildContext context, AsyncSnapshot<jisho.KanjiResult> snapshot) {
      if (snapshot.hasData) {
        return KanjiResultCard(snapshot.data);
      } else if (snapshot.hasError) {
        throw 'ASYNC ERROR';
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
