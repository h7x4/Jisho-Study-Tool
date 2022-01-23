import 'package:flutter/material.dart';

import '../../../../../bloc/theme/theme_bloc.dart';
import 'search_chip.dart';

class EnglishDefinitions extends StatelessWidget {
  final List<String> englishDefinitions;
  final ColorSet colors;

  const EnglishDefinitions({
    Key? key,
    required this.englishDefinitions,
    this.colors = LightTheme.defaultMenuGreyNormal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        runSpacing: 10.0,
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final def in englishDefinitions)
            SearchChip(text: def, colors: colors)
        ],
      );
}
