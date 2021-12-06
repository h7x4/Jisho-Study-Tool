import 'package:flutter/material.dart';

import '../../../../bloc/theme/theme_bloc.dart';

class JlptLevel extends StatelessWidget {
  final String jlptLevel;

  const JlptLevel({
    required this.jlptLevel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _kanjiColors =
        BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _kanjiColors.background,
      ),
      child: Text(
        jlptLevel,
        style: TextStyle(
          color: _kanjiColors.foreground,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
