import 'package:flutter/material.dart';

import 'view/home.dart';
import 'view/screens/search/kanji_result_page.dart';
import 'view/screens/search/search_mechanisms/drawing.dart';
import 'view/screens/search/search_mechanisms/radical_list.dart';
import 'view/screens/search/search_results_page.dart';

Route<Widget> generateRoute(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Home());

    case '/search':
      final searchTerm = args! as String;
      return MaterialPageRoute(
        builder: (_) => SearchResultsPage(searchTerm: searchTerm),
      );

    case '/kanjiSearch':
      final searchTerm = args! as String;
      return MaterialPageRoute(
        builder: (_) => KanjiResultPage(kanjiSearchTerm: searchTerm),
      );

    case '/kanjiSearch/draw':
      return MaterialPageRoute(builder: (_) => const KanjiDrawingSearch());

    case '/kanjiSearch/radicals':
      return MaterialPageRoute(builder: (_) => const KanjiRadicalSearch());

    default:
      return MaterialPageRoute(
        builder: (_) => const Text('ERROR: this route does not exist'),
      );
  }
}
