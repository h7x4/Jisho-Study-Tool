import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

class Radical extends StatelessWidget {
  final jisho.Radical radical;

  const Radical(this.radical);

  @override
  Widget build(BuildContext context) {
    final _kanjiColors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        radical.symbol,
        style: TextStyle(
          color: _kanjiColors.foreground,
          fontSize: 40.0,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _kanjiColors.background,
      ),
    );
  }
}