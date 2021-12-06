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

  SearchResultCard({
    required this.result,
    Key? key,
  })  : mainWord = result.japanese[0],
        otherForms = result.japanese.sublist(1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return ExpansionTile(
      collapsedBackgroundColor: backgroundColor,
      backgroundColor: backgroundColor,
      title: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            JapaneseHeader(word: mainWord),
            Row(
              children: [
                WKBadge(
                  level: result.tags.firstWhere(
                    (tag) => tag.contains('wanikani'),
                    orElse: () => '',
                  ),
                ),
                JLPTBadge(
                  jlptLevel: result.jlpt.isNotEmpty ? result.jlpt[0] : '',
                ),
                CommonBadge(isCommon: result.isCommon ?? false)
              ],
            )
          ],
        ),
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Senses(senses: result.senses),
              OtherForms(forms: otherForms),
              // Text(result.toJson().toString()),
              // Text(result.attribution.toJson().toString()),
              // Text(result.japanese.map((e) => e.toJson().toString()).toList().toString()),
            ],
          ),
        )
      ],
    );
  }
}
