import 'package:flutter/material.dart';

import '../../../bloc/theme/theme_bloc.dart';

class Grade extends StatelessWidget {
  final String? grade;
  final String ifNullChar;

  const Grade({
    required this.grade,
    this.ifNullChar = '⨉',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors =
        BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colors.background,
        shape: BoxShape.circle,
      ),
      child: Text(
        grade ?? ifNullChar,
        style: TextStyle(
          color: colors.foreground,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
