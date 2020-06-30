import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import 'package:jisho_study_tool/components/kanjiSearch/kanji_search_card.dart';

Widget searchForKanji(String kanji) {
  return FutureBuilder(
    future: jisho.searchForKanji(kanji),
    builder: (BuildContext context, AsyncSnapshot<jisho.KanjiResult> snapshot) {
      return KanjiResultCard(snapshot.data);
    }
  );
}