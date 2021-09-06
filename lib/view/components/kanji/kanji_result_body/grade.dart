import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';

class Grade extends StatelessWidget {
  final String grade;

  const Grade(this.grade);

  @override
  Widget build(BuildContext context) {
    final _kanjiColors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        grade,
        style: TextStyle(
          color: _kanjiColors.foreground,
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        color: _kanjiColors.background,
        shape: BoxShape.circle,
      ),
    );
  }
}