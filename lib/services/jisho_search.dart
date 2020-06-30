import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import 'package:jisho_study_tool/components/kanjiSearch/kanji_search_card.dart';

Future<Widget> searchKanji(String kanji) async {
  KanjiResult result = await searchForKanji(kanji);
  return KanjiResultCard(result);
}