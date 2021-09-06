import 'package:flutter/material.dart';
import 'package:jisho_study_tool/view/screens/search/kanji_result_page.dart';
import 'package:jisho_study_tool/view/screens/search/search_results_page.dart';

import 'main.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());

      case '/search':
        final searchTerm = args as String;
        return MaterialPageRoute(builder: (_) => SearchResultsPage(searchTerm: searchTerm));

      case '/kanjiSearch':
        final searchTerm = args as String;
        return MaterialPageRoute(builder: (_) => KanjiResultPage(kanjiSearchTerm: searchTerm));

      default:
        return MaterialPageRoute(builder: (_) => Text("ERROR: this route does not exist"));
    }
  }
}
