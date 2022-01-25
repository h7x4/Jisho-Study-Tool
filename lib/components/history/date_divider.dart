import 'package:flutter/material.dart';

import '../../bloc/theme/theme_bloc.dart';

class TextDivider extends StatelessWidget {
  final String text;

  const TextDivider({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final colors = state.theme.menuGreyNormal;

          return Container(
            decoration: BoxDecoration(color: colors.background),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: DefaultTextStyle.merge(
              child: Text(text),
              style: TextStyle(color: colors.foreground),
            ),
          );
        },
      );
}
