import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../bloc/theme/theme_bloc.dart';
import '../../../routing/routes.dart';
import '../../../services/romaji_transliteration.dart';
import '../../../settings.dart';

class Examples extends StatelessWidget {
  final List<YomiExample> onyomi;
  final List<YomiExample> kunyomi;

  const Examples({
    Key? key,
    required this.onyomi,
    required this.kunyomi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 20);

    final yomiWidgets =
        onyomi.map((onEx) => _Example(onEx, _KanaType.onyomi)).toList() +
            kunyomi.map((kunEx) => _Example(kunEx, _KanaType.kunyomi)).toList();

    const noExamplesWidget = Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text('No Examples', style: textStyle),
    );

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          child: const Text('Examples:', style: textStyle),
        ),
        if (onyomi.isEmpty && kunyomi.isEmpty)
          noExamplesWidget
        else
          ...yomiWidgets
      ],
    );
  }
}

enum _KanaType { kunyomi, onyomi }

class _Example extends StatelessWidget {
  final _KanaType kanaType;
  final YomiExample yomiExample;

  const _Example(this.yomiExample, this.kanaType);

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final theme = state.theme;
          final menuColors = theme.menuGreyNormal;
          final kanaColors = kanaType == _KanaType.kunyomi
              ? theme.kunyomiColor
              : theme.onyomiColor;

          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: menuColors.background,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.search,
                      arguments: yomiExample.example,
                    ),
                    child: _Kana(colors: kanaColors, example: yomiExample),
                  ),
                  _ExampleText(colors: menuColors, example: yomiExample)
                ],
              ),
            ),
          );
        },
      );
}

class _Kana extends StatelessWidget {
  final ColorSet colors;
  final YomiExample example;

  const _Kana({
    Key? key,
    required this.colors,
    required this.example,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            romajiEnabled
                ? transliterateKanaToLatin(example.reading)
                : example.reading,
            style: TextStyle(
              color: colors.foreground,
              fontSize: 15.0,
            ).merge(!romajiEnabled ? japaneseFont.textStyle : null),
          ),
          const SizedBox(height: 5.0),
          Text(
            example.example,
            style: TextStyle(
              color: colors.foreground,
              fontSize: 20.0,
            ).merge(japaneseFont.textStyle),
          ),
        ],
      ),
    );
  }
}

class _ExampleText extends StatelessWidget {
  final ColorSet colors;
  final YomiExample example;

  const _ExampleText({
    Key? key,
    required this.colors,
    required this.example,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            Text(
              example.meaning,
              style: TextStyle(
                color: colors.foreground,
              ),
            )
          ],
        ),
      ),
    );
  }
}
