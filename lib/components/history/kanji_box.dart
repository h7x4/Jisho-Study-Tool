import 'package:flutter/material.dart';

import '../../bloc/theme/theme_bloc.dart';

class KanjiBox extends StatelessWidget {
  final String kanji;

  const KanjiBox({
    Key? key,
    required this.kanji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: AspectRatio(
          aspectRatio: 1,
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              final colors = state.theme.menuGreyLight;
              return Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      kanji,
                      style: TextStyle(
                        color: colors.foreground,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
}
