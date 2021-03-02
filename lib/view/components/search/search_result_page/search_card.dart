import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart';

import './parts/header.dart';
import './parts/senses.dart';
import './parts/other_forms.dart';

class SearchResultCard extends StatelessWidget {
  final JishoResult result;
  JishoJapaneseWord mainWord;
  List<JishoJapaneseWord> otherForms;

  SearchResultCard(this.result) {
    this.mainWord = result.japanese[0];
    this.otherForms = result.japanese.sublist(1);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: JapaneseHeader(mainWord),
      children: [
        Senses(result.senses),
        OtherForms(otherForms),
      ],
    );
  }
}
