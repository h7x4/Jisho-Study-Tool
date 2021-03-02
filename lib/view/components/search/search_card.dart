import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart';

import 'parts/header.dart';
import 'parts/senses.dart';
import 'parts/other_forms.dart';

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
      title: JapaneseHeader(_mainWord),
      children: [
        Senses(_result.senses),
        OtherForms(_otherForms),
      ],
    );
  }
}
