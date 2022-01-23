import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import 'sense/sense.dart';

class Senses extends StatelessWidget {
  final List<JishoWordSense> senses;
  final List<PhraseScrapeMeaning>? extraData;

  const Senses({
    required this.senses,
    this.extraData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> senseWidgets = senses
        .asMap()
        .map(
          (k, v) => MapEntry(
            v,
            extraData?.firstWhereOrNull(
              (m) => m.definition == v.englishDefinitions.join('; '),
            ),
          ),
        )
        .entries
        .toList()
        .asMap()
        .entries
        .map(
          (e) => Sense(
            index: e.key,
            sense: e.value.key,
            meaning: e.value.value,
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: senseWidgets,
    );
  }
}
