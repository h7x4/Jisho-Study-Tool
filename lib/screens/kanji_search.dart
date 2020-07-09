import 'package:flutter/material.dart';
import 'package:jisho_study_tool/services/jisho_search.dart';

class KanjiSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kanjiCard = searchForKanji('谷');
    return Column(
      children: [kanjiCard],
    );
  }
}
