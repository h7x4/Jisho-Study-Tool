import 'package:flutter/material.dart';
import 'package:jisho_study_tool/view/components/search/search_result_page/parts/common_badge.dart';
import 'package:jisho_study_tool/view/components/search/search_result_page/parts/jlpt_badge.dart';
import 'package:jisho_study_tool/view/components/search/search_result_page/parts/wanikani_badge.dart';

import 'package:unofficial_jisho_api/api.dart';

import './parts/header.dart';
import './parts/senses.dart';
import './parts/other_forms.dart';

class SearchResultCard extends StatelessWidget {
  final JishoResult result;
  late final JishoJapaneseWord mainWord;
  late final List<JishoJapaneseWord> otherForms;

  SearchResultCard(this.result) {
    this.mainWord = result.japanese[0];
    this.otherForms = result.japanese.sublist(1);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: 
      IntrinsicWidth(
        child: Row(
          children: [
            JapaneseHeader(mainWord),
            Row(
              children: [
                WKBadge(result.tags.firstWhere((tag) => tag.contains("wanikani"), orElse: () => '')),
                JLPTBadge(result.jlpt.isNotEmpty ? result.jlpt[0] : ''),
                CommonBadge(result.isCommon!)
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      children: [
        Container(
          child: Column(
            children: [
              Senses(result.senses),
              OtherForms(otherForms),
              // Text(result.toJson().toString()),
              // Text(result.attribution.toJson().toString()),
              // Text(result.japanese.map((e) => e.toJson().toString()).toList().toString()),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 30),
        )
      ],
    );
  }
}
