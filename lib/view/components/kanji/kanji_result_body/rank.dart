import 'package:flutter/material.dart';

import '../../../../bloc/theme/theme_bloc.dart';

class Rank extends StatelessWidget {
  final int rank;

  const Rank({required this.rank, Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _kanjiColors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: _kanjiColors.background,
      ),
      child: Text(
        '${rank.toString()} / 2500',
        style: TextStyle(
          color: _kanjiColors.foreground,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
