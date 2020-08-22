import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

class JapaneseHeader extends StatelessWidget {
  final JishoJapaneseWord _word;
  const JapaneseHeader(this._word);

  @override
  Widget build(BuildContext context) {
    final hasFurigana = (_word.word != null);

    return Container(
      child: Column(
        children: [
          (hasFurigana) ? Text(_word.reading) : Text(''),
          (hasFurigana) ? Text(_word.word) : Text(_word.reading),
        ],
      ),
    );
  }
}
