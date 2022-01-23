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

  List<Widget> get _senseWidgets => [
        for (int i = 0; i < senses.length; i++)
          Sense(
            index: i,
            sense: senses[i],
            meaning: extraData?.firstWhereOrNull(
              (m) => m.definition == senses[i].englishDefinitions.join('; '),
            ),
          ),
      ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _senseWidgets,
      );
}
