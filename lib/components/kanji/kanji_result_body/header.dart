import 'package:flutter/material.dart';

import '../../../bloc/theme/theme_bloc.dart';

class Header extends StatelessWidget {
  final String kanji;

  const Header({
    required this.kanji,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors =
        BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colors.background,
        ),
        child: Center(
          child: Text(
            kanji,
            style: TextStyle(fontSize: 70.0, color: colors.foreground),
          ),
        ),
      ),
    );
  }
}
