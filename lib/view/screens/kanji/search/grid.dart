import 'package:flutter/material.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_grid.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_search_bar.dart';

class SearchGrid extends StatelessWidget {
  final List<String> suggestions;
  const SearchGrid(this.suggestions);

  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: [
          SizedBox(height: 10),
          KanjiSearchBar(),
          SizedBox(height: 10),
          Expanded(
            child: KanjiGrid(suggestions)
          )
        ],
      );
  }
}