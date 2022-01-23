import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../models/themes/theme.dart';
import '../../../../services/romaji_transliteration.dart';
import '../../../../settings.dart';

class KanjiKanaBox extends StatelessWidget {
  final JishoJapaneseWord word;
  final bool showRomajiBelow;
  final ColorSet colors;
  final bool autoTransliterateRomaji;
  final bool centerFurigana;
  final double? furiganaFontsize;
  final double? kanjiFontsize;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const KanjiKanaBox({
    Key? key,
    required this.word,
    this.showRomajiBelow = false,
    this.colors = LightTheme.defaultMenuGreyNormal,
    this.autoTransliterateRomaji = true,
    this.centerFurigana = true,
    this.furiganaFontsize,
    this.kanjiFontsize,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 5.0,
      vertical: 5.0,
    ),
    this.padding = const EdgeInsets.all(5.0),
  }) : super(key: key);

  bool get hasFurigana => word.reading != null;

  String get kana => '${word.reading ?? ""}${word.word ?? ""}'
      .replaceAll(RegExp(r'\p{Script=Hani}', unicode: true), '');

  @override
  Widget build(BuildContext context) {
    final String? wordReading = word.reading == null
        ? null
        : (romajiEnabled && autoTransliterateRomaji
            ? transliterateKanaToLatin(word.reading!)
            : word.reading!);

    final fFontsize = furiganaFontsize ??
        ((kanjiFontsize != null) ? 0.8 * kanjiFontsize! : null);

    return Container(
      margin: margin,
      padding: padding,
      color: colors.background,
      child: DefaultTextStyle.merge(
        child: Column(
          crossAxisAlignment: centerFurigana
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            // See header.dart for more details about this logic
            hasFurigana
                ? Text(
                    wordReading!,
                    style: TextStyle(
                      fontSize: fFontsize,
                      color: colors.foreground,
                    ).merge(
                      romajiEnabled && autoTransliterateRomaji
                          ? null
                          : japaneseFont.textStyle,
                    ),
                  )
                : Text(
                    'あ',
                    style: TextStyle(
                      color: Colors.transparent,
                      fontSize: fFontsize,
                    ),
                  ),

            DefaultTextStyle.merge(
              child: hasFurigana
                  ? Text(word.word ?? word.reading!)
                  : Text(wordReading ?? word.word!),
              style: TextStyle(fontSize: kanjiFontsize)
                  .merge(japaneseFont.textStyle),
            ),
            if (romajiEnabled && showRomajiBelow)
              Text(
                transliterateKanaToLatin(kana),
              )
          ],
        ),
        style: TextStyle(color: colors.foreground),
      ),
    );
  }
}
