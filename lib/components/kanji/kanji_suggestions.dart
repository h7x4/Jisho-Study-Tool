import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';

class KanjiSuggestions extends StatelessWidget {
  final List<String> _suggestions;
  const KanjiSuggestions(this._suggestions);

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
        children: _suggestions.map((kanji) => _Suggestion(kanji)).toList(),
      ),
    );
  }
}

class _Suggestion extends StatelessWidget {
  final String _kanji;
  const _Suggestion(this._kanji);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus(); //Puts away the keyboard
        BlocProvider.of<KanjiBloc>(context).add(GetKanji(_kanji));
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
              _kanji,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
