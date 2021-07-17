
import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart' as jisho;

import 'package:jisho_study_tool/view/components/kanji/result/grade.dart';
import 'package:jisho_study_tool/view/components/kanji/result/header.dart';
import 'package:jisho_study_tool/view/components/kanji/result/jlpt_level.dart';
import 'package:jisho_study_tool/view/components/kanji/result/meaning.dart';
import 'package:jisho_study_tool/view/components/kanji/result/radical.dart';
import 'package:jisho_study_tool/view/components/kanji/result/rank.dart';
import 'package:jisho_study_tool/view/components/kanji/result/stroke_order_gif.dart';
import 'package:jisho_study_tool/view/components/kanji/result/onyomi.dart';
import 'package:jisho_study_tool/view/components/kanji/result/kunyomi.dart';
import 'package:jisho_study_tool/view/components/kanji/result/examples.dart';

class KanjiResultCard extends StatelessWidget {
  final jisho.KanjiResult result;

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
                child: Center(child: Header(result.query)),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Radical(result.radical),
                ),
              ),
            ],
          ),
        ),
        Meaning(result.meaning),
        result.onyomi.length != 0 ? Onyomi(result.onyomi) : SizedBox.shrink(),
        result.kunyomi.length != 0 ? Kunyomi(result.kunyomi) : SizedBox.shrink(),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StrokeOrderGif(result.strokeOrderGifUri),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("JLPT: ", style: TextStyle(fontSize: 20.0)),
                        JlptLevel(result.jlptLevel ?? "⨉"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Grade: ", style: TextStyle(fontSize: 20.0)),
                        Grade(result.taughtIn ?? "⨉"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Rank: ", style: TextStyle(fontSize: 20.0)),
                        Rank(result.newspaperFrequencyRank ?? -1),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Examples(result.onyomiExamples, result.kunyomiExamples),
      ],
    );
  }

  KanjiResultCard(this.result);
}