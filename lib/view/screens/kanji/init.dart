import 'package:flutter/material.dart';

import 'package:jisho_study_tool/view/components/kanji/kanji_search_bar.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: KanjiSearchBar(),
    );

  }
}