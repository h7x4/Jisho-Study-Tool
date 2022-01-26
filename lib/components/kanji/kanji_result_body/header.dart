import 'package:flutter/material.dart';

import '../../../bloc/theme/theme_bloc.dart';
import '../../../settings.dart';

class Header extends StatelessWidget {
  final String kanji;

  const Header({
    required this.kanji,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final colors = state.theme.kanjiResultColor;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: colors.background,
              ),
              child: FittedBox(
                child: Text(
                  kanji,
                  style: TextStyle(color: colors.foreground)
                      .merge(japaneseFont.textStyle),
                ),
              ),
            );
          },
        ),
      );
}
