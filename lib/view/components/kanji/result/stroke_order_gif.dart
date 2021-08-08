import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';

class StrokeOrderGif extends StatelessWidget {
  final String uri;

  const StrokeOrderGif(this.uri);

  @override
  Widget build(BuildContext context) {
    final _kanjiColors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.all(5.0),
      child: ClipRRect(
        child: Image.network(uri),
        borderRadius: BorderRadius.circular(10.0),
      ),
      decoration: BoxDecoration(
        color: _kanjiColors.background,
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}