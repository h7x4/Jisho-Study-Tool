
import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';

class JlptLevel extends StatelessWidget {
  final String jlptLevel;

  const JlptLevel(this.jlptLevel);

  @override
  Widget build(BuildContext context) {
    final _kanjiColors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        jlptLevel,
        style: TextStyle(
          color: _kanjiColors.foreground,
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _kanjiColors.background,
      ),
    );
  }
}