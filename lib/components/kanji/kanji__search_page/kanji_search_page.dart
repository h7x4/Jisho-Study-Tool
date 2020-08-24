import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart' as jisho;

import 'parts/grade.dart';
import 'parts/header.dart';
import 'parts/jlpt_level.dart';
import 'parts/meaning.dart';
import 'parts/radical.dart';
import 'parts/rank.dart';
import 'parts/stroke_order_gif.dart';
import 'parts/onyomi.dart';
import 'parts/kunyomi.dart';
import 'parts/examples.dart';

class KanjiResultCard extends StatelessWidget {
  final jisho.KanjiResult _result;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(child: SizedBox()),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(child: Header(_result.query)),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Radical(_result.radical),
                ),
              ),
            ],
          ),
        ),
        Meaning(_result.meaning),
        _result.onyomi.length != 0 ? Onyomi(_result.onyomi) : SizedBox.shrink(),
        _result.kunyomi.length != 0 ? Kunyomi(_result.kunyomi) : SizedBox.shrink(),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StrokeOrderGif(_result.strokeOrderGifUri),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("JLPT: ", style: TextStyle(fontSize: 20.0)),
                        JlptLevel(_result.jlptLevel ?? "⨉"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Grade: ", style: TextStyle(fontSize: 20.0)),
                        Grade(_result.taughtIn ?? "⨉"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Rank: ", style: TextStyle(fontSize: 20.0)),
                        Rank(_result.newspaperFrequencyRank ?? -1),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Examples(_result.onyomiExamples, _result.kunyomiExamples),
      ],
    );
  }

  KanjiResultCard(this._result);
}
