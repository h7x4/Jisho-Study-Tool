import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/search/kanji_result_page.dart';
import '../screens/search/search_mechanisms/drawing.dart';
import '../screens/search/search_mechanisms/grade_list.dart';
import '../screens/search/search_mechanisms/radical_list.dart';
import '../screens/search/search_results_page.dart';
import 'routes.dart';

Route<Widget> generateRoute(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case Routes.root:
      return MaterialPageRoute(builder: (_) => const Home());

    case Routes.search:
      final searchTerm = args! as String;
      return MaterialPageRoute(
        builder: (_) => SearchResultsPage(searchTerm: searchTerm),
      );

    case Routes.kanjiSearch:
      final searchTerm = args! as String;
      return MaterialPageRoute(
        builder: (_) => KanjiResultPage(kanjiSearchTerm: searchTerm),
      );

    case Routes.kanjiSearchDraw:
      return MaterialPageRoute(builder: (_) => const KanjiDrawingSearch());

    case Routes.kanjiSearchGrade:
      return MaterialPageRoute(builder: (_) => const KanjiGradeSearch());

    case Routes.kanjiSearchRadicals:
      final prechosenRadical = args as String?;
      return MaterialPageRoute(builder: (_) => KanjiRadicalSearch(prechosenRadical: prechosenRadical));

    // TODO: Add more specific error screens.
    case Routes.errorNotFound:
    case Routes.errorNetwork:
    case Routes.errorOther:
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar:
              AppBar(title: const Text('Error'), backgroundColor: Colors.red),
          body: Center(child: ErrorWidget('Some kind of error occured')),
        ),
      );
  }
}
