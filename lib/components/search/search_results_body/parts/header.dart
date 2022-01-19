import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

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
      child: Column(
        children: [
          // Both wordReading and word.word being present implies that the word has furigana.
          // If that's not the case, then the word is usually present in wordReading.
          // However, there are some exceptions where the reading is placed in word.
          // I have no clue why this might be the case.
          hasFurigana ? Text(wordReading!) : const Text(''),
          hasFurigana ? Text(word.word!) : Text(wordReading ?? word.word!),
        ],
      ),
    );
  }
}
