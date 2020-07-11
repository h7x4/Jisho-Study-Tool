import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import 'package:jisho_study_tool/components/kanji/kanji__search_page/kanji_search_page.dart';
import 'package:jisho_study_tool/services/kanji_search.dart';

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
