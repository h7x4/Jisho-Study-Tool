import 'package:flutter/material.dart';
import 'package:jisho_study_tool/services/jisho_search.dart';

class KanjiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return searchForKanji('谷');
  }
}
