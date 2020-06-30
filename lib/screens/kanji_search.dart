import 'package:flutter/material.dart';
import 'package:jisho_study_tool/components/kanjiSearch/kanji_search_card.dart';
import 'package:jisho_study_tool/services/jisho_search.dart';

class KanjiSearch extends StatefulWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [searchKanji('金')],
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}