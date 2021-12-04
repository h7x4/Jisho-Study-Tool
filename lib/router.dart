import 'package:flutter/material.dart';

import 'main.dart';
import 'view/screens/search/kanji_result_page.dart';
import 'view/screens/search/search_results_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
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

    default:
      return MaterialPageRoute(
        builder: (_) => const Text('ERROR: this route does not exist'),
      );
  }
}
