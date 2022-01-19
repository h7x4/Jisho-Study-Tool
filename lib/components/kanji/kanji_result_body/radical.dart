import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import '../../../bloc/theme/theme_bloc.dart';

class Radical extends StatelessWidget {
  final jisho.Radical radical;

  const Radical({required this.radical, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.background,
      ),
      child: Text(
        radical.symbol,
        style: TextStyle(
          color: colors.foreground,
          fontSize: 40.0,
        ),
      ),
    );
  }
}
