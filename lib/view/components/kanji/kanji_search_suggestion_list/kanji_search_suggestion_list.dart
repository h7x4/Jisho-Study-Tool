import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';

class KanjiSuggestions extends StatelessWidget {
  final List<String> suggestions;
  const KanjiSuggestions(this.suggestions);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 40.0,
      ),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 40.0,
        children: suggestions.map((kanji) => _Suggestion(kanji)).toList(),
      ),
    );
  }
}

class _Suggestion extends StatelessWidget {
  final String kanji;
  const _Suggestion(this.kanji);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<KanjiBloc>(context).add(GetKanji(kanji));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: FittedBox(
            child: Text(
              kanji,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
