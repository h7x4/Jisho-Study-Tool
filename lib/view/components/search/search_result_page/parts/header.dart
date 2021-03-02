import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

class JapaneseHeader extends StatelessWidget {
  final JishoJapaneseWord word;
  const JapaneseHeader(this.word);

  @override
  Widget build(BuildContext context) {
    final hasFurigana = (word.word != null);

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          (hasFurigana) ? Text(word.reading) : Text(''),
          (hasFurigana) ? Text(word.word) : Text(word.reading),
        ],
      ),
    );
  }
}
