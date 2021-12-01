import 'package:flutter/material.dart';

import '../../../../bloc/theme/theme_bloc.dart';

class Grade extends StatelessWidget {
  final String grade;

  const Grade({required this.grade, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _kanjiColors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kanjiColors.background,
        shape: BoxShape.circle,
      ),
      child: Text(
        grade,
        style: TextStyle(
          color: _kanjiColors.foreground,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
