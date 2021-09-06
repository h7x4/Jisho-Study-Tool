import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import './parts/common_badge.dart';
import './parts/header.dart';
import './parts/jlpt_badge.dart';
import './parts/other_forms.dart';
import './parts/senses.dart';
import './parts/wanikani_badge.dart';

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
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return ExpansionTile(
      collapsedBackgroundColor: backgroundColor,
      backgroundColor: backgroundColor,
      title: 
      IntrinsicWidth(
        child: Row(
          children: [
            JapaneseHeader(mainWord),
            Row(
              children: [
                WKBadge(result.tags.firstWhere((tag) => tag.contains("wanikani"), orElse: () => '')),
                JLPTBadge(result.jlpt.isNotEmpty ? result.jlpt[0] : ''),
                CommonBadge(result.isCommon ?? false)
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
