import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

class JapaneseHeader extends StatelessWidget {
  final JishoJapaneseWord word;
  const JapaneseHeader(this.word);

  @override
  Widget build(BuildContext context) {
    final hasFurigana = (word.word != null && word.reading != null);

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          // TODO: take a look at this logic
          (hasFurigana) ? Text(word.reading!) : Text(''),
          (hasFurigana) ? Text(word.word!) : Text(word.reading ?? word.word!),
        ],
      ),
    );
  }
}
