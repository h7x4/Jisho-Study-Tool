import 'package:flutter/material.dart';

import '../../../../bloc/theme/theme_bloc.dart';
import '../../../../services/jisho_api/radicals.dart';
import '../../../../services/jisho_api/radicals_search.dart';

class KanjiRadicalSearch extends StatefulWidget {
  const KanjiRadicalSearch({Key? key}) : super(key: key);

  @override
  _KanjiRadicalSearchState createState() => _KanjiRadicalSearchState();
}

class _KanjiRadicalSearchState extends State<KanjiRadicalSearch> {
  static const double fontSize = 25;

  List<String> suggestions = [];

  Map<String, bool> radicalToggles = {
    for (final String r in radicals.values.expand((l) => l)) r: false
  };

  Map<String, bool> allowedToggles = {
    for (final String r in radicals.values.expand((l) => l)) r: true
  };

  void resetRadicalToggles() => radicalToggles.forEach((k, _) {
        radicalToggles[k] = false;
      });

  void resetAllowedToggles() => allowedToggles.forEach((k, _) {
        allowedToggles[k] = true;
      });

  Future<void> updateSuggestions() async {
    final toggledRadicals =
        radicalToggles.keys.where((r) => radicalToggles[r] ?? false).toList();

    if (toggledRadicals.isEmpty) {
      suggestions.clear();
      resetAllowedToggles();
      return;
    }

    final newSuggestions = await searchKanjiByRadicals(toggledRadicals);

    setState(() {
      allowedToggles.forEach((key, value) {
        allowedToggles[key] = false;
      });
      for (final r in newSuggestions.validRadicals) {
        allowedToggles[r] = true;
      }
      suggestions = (newSuggestions.kanji
            ..sort((a, b) => a.strokes.compareTo(b.strokes)))
          .map((k) => k.kanji)
          .toList();
    });
  }

  Widget radicalGridElement(String radical, {bool isNumber = false}) {
    // final theme = BlocProvider.of<ThemeBloc>(context).state.theme;
    final theme = LightTheme();

    final color = isNumber
        ? theme.menuGreyDark
        : radicalToggles[radical]!
            ? AppTheme.jishoGreen
            : theme.menuGreyNormal;

    return InkWell(
      onTap: isNumber
          ? () {}
          : () => setState(() {
                // TODO: Don't let the user toggle on another kanji before the last one is updated
                radicalToggles[radical] = !radicalToggles[radical]!;
                updateSuggestions();
              }),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color.background,
        ),
        child: Text(
          radical,
          style: TextStyle(
            color: color.foreground,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }

  List<Widget> get radicalGridElements =>
      <Widget>[
        IconButton(
          onPressed: () => setState(() {
            suggestions.clear();
            resetRadicalToggles();
            resetAllowedToggles();
          }),
          icon: const Icon(Icons.restore),
          color: AppTheme.jishoGreen.background,
          iconSize: fontSize * 1.3,
        ),
      ] +
      radicals
          .map(
            (key, value) => MapEntry(
              key,
              value
                  .where((r) => allowedToggles[r]!)
                  .map((r) => radicalGridElement(r))
                  .toList()
                ..insert(0, radicalGridElement(key.toString(), isNumber: true)),
            ),
          )
          .values
          .where((element) => element.length != 1)
          .expand((l) => l)
          .toList();

  Widget kanjiGridElement(String kanji) {
    final color = LightTheme().menuGreyNormal;
    return InkWell(
      onTap: () => Navigator.popAndPushNamed(
        context,
        '/kanjiSearch',
        arguments: kanji,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color.background,
        ),
        alignment: Alignment.center,
        child: Text(
          kanji,
          style: TextStyle(
            color: color.foreground,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose by radicals')),
      body: Column(
        children: [
          Expanded(
            child: (suggestions.isEmpty)
                ? Center(
                    child: Text(
                      'Toggle a radical to start',
                      style: TextStyle(
                        fontSize: fontSize * 0.8,
                        color: BlocProvider.of<ThemeBloc>(context)
                            .state
                            .theme
                            .menuGreyNormal
                            .background,
                      ),
                    ),
                  )
                : GridView.count(
                    crossAxisCount: 6,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding: const EdgeInsets.all(10),
                    children:
                        suggestions.map((s) => kanjiGridElement(s)).toList(),
                  ),
          ),
          Divider(
            color: AppTheme.jishoGreen.background,
            thickness: 3,
            height: 30,
            indent: 5,
            endIndent: 5,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 6,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              children: radicalGridElements,
            ),
          ),
        ],
      ),
    );
  }
}
