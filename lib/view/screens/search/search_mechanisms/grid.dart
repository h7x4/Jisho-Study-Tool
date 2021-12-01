import 'package:flutter/material.dart';

import '../../../components/kanji/kanji_search_body/kanji_grid.dart';
import '../../../components/kanji/kanji_search_body/kanji_search_bar.dart';

class SearchGrid extends StatelessWidget {
  final List<String> suggestions;

  const SearchGrid({
    required this.suggestions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const KanjiSearchBar(),
        const SizedBox(height: 10),
        Expanded(child: KanjiGrid(suggestions: suggestions))
      ],
    );
  }
}
