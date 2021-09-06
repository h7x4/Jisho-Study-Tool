import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';

class Header extends StatelessWidget {
  final String kanji;

  const Header(this.kanji);

  @override
  Widget build(BuildContext context) {
    final _kanjiColors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _kanjiColors.background,
        ),
        child: Center(
          child: Text(
            kanji,
            style: TextStyle(fontSize: 70.0, color: _kanjiColors.foreground),
          ),
        ),
      ),
    );
  }
}
