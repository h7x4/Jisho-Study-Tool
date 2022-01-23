import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../../models/themes/theme.dart';
import '../kanji_kana_box.dart';

class Sentences extends StatelessWidget {
  final List<PhraseScrapeSentence> sentences;
  final ColorSet colors;

  const Sentences({
    Key? key,
    required this.sentences,
    this.colors = LightTheme.defaultMenuGreyNormal,
  }) : super(key: key);

  Widget _sentence(PhraseScrapeSentence sentence) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 10,
              children: [
                ...sentence.pieces
                    .map(
                      (p) => JishoJapaneseWord(
                        word: p.unlifted,
                        reading: p.lifted,
                      ),
                    )
                    .map(
                      (word) => KanjiKanaBox(
                        word: word,
                        showRomajiBelow: true,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        centerFurigana: false,
                        autoTransliterateRomaji: false,
                        kanjiFontsize: 15,
                        furiganaFontsize: 12,
                        colors: colors,
                      ),
                    )
                    .toList(),
              ],
            ),
            Divider(
              height: 20,
              color: Colors.grey[400],
              thickness: 3,
            ),
            Text(
              sentence.english,
              style: TextStyle(color: colors.foreground),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sentences.map((s) => _sentence(s)).toList(),
    );
  }
}
