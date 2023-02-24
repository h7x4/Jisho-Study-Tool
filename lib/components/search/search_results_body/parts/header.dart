import 'package:flutter/material.dart';
import 'package:ruby_text/ruby_text.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../services/jisho_api/kanji_furigana_separation.dart';
import '../../../../services/romaji_transliteration.dart';
import '../../../../settings.dart';

class JapaneseHeader extends StatelessWidget {
  final JishoJapaneseWord word;

  const JapaneseHeader({
    required this.word,
    Key? key,
  }) : super(key: key);

  bool get hasFurigana => word.word != null && word.reading != null;

  @override
  Widget build(BuildContext context) {
    final String? wordReading = word.reading == null
        ? null
        : (romajiEnabled
            ? transliterateKanaToLatin(word.reading!)
            : word.reading!);

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10.0),
      child: RubySpanWidget(
        RubyTextData(
          word.kanji,
          ruby: word.furigana,
          style: romajiEnabled ? null : japaneseFont.textStyle,
          rubyStyle: romajiEnabled ? null : japaneseFont.textStyle,
        ),
      ),
    );
  }
}
