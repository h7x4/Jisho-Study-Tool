import 'package:flutter/material.dart';

import '../../bloc/theme/theme_bloc.dart';

class KanjiBox extends StatelessWidget {
  final String kanji;

  const KanjiBox({
    Key? key,
    required this.kanji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorSet menuColors =
        BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyLight;

    return IntrinsicHeight(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: menuColors.background,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                kanji,
                style: TextStyle(
                  color: menuColors.foreground,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
