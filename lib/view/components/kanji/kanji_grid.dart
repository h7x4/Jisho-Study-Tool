import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';

class KanjiGrid extends StatelessWidget {
  final List<String> suggestions;
  const KanjiGrid(this.suggestions);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 40.0,
      ),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        children: suggestions.map((kanji) => _GridItem(kanji)).toList(),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  final String kanji;
  const _GridItem(this.kanji);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<KanjiBloc>(context).add(GetKanji(kanji));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: FittedBox(
            child: Text(
              kanji,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}