import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../models/themes/theme.dart';
import '../../../../services/romaji_transliteration.dart';
import '../../../../settings.dart';

class KanjiKanaBox extends StatelessWidget {
  final JishoJapaneseWord word;
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

  bool get hasFurigana => word.word != null;

  @override
  Widget build(BuildContext context) {
    final String? wordReading = word.reading == null
        ? null
        : (romajiEnabled && autoTransliterateRomaji
            ? transliterateKanaToLatin(word.reading!)
            : word.reading!);

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: colors.background,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 0.5,
        //     offset: const Offset(1, 1),
        //   ),
        // ],
      ),
      child: DefaultTextStyle.merge(
        child: Column(
          crossAxisAlignment: centerFurigana ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            // See header.dart for more details about this logic
            hasFurigana
                ? Text(
                    wordReading ?? 'あ',
                    style: TextStyle(
                      fontSize: furiganaFontsize ??
                          ((kanjiFontsize != null)
                              ? 0.8 * kanjiFontsize!
                              : null),
                      color: wordReading != null ? colors.foreground : Colors.transparent,
                    ),
                  )
                : const Text(''),
            DefaultTextStyle.merge(
              child: hasFurigana
                  ? Text(word.word!)
                  : Text(wordReading ?? word.word!),
              style: TextStyle(fontSize: kanjiFontsize),
            )
          ],
        ),
        style: TextStyle(color: colors.foreground),
      ),
    );
  }
}
