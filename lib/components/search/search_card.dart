import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart';

class SearchResultCard extends StatelessWidget {
  final JishoResult _result;
  JishoJapaneseWord _mainWord;
  List<JishoJapaneseWord> _otherForms;

  SearchResultCard(this._result) {
    this._mainWord = _result.japanese[0];
    this._otherForms = _result.japanese.sublist(1);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _JapaneseHeader(_mainWord),
      children: [_OtherForms(_otherForms)],
    );
  }
}

class _JapaneseHeader extends StatelessWidget {
  final JishoJapaneseWord _word;
  const _JapaneseHeader(this._word);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _KanaBox(_word),
    );
  }
}

class _OtherForms extends StatelessWidget {
  final List<JishoJapaneseWord> _otherForms;
  _OtherForms(this._otherForms);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: _otherForms.map((form) => _KanaBox(form)).toList(),
    ));
  }
}

class _KanaBox extends StatelessWidget {
  final JishoJapaneseWord _word;
  const _KanaBox(this._word);

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
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 0.5,
            offset: Offset(1, 1),
          ),
        ],
      ),
    );
  }
}
