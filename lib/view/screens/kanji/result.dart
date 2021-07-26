
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
  late final String query;
  late final jisho.KanjiResultData resultData;

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
                child: Center(child: Header(query)),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: (resultData.radical != null) ? Radical(resultData.radical!) : SizedBox(),
                ),
              ),
            ],
          ),
        ),
        Meaning(resultData.meaning),
        resultData.onyomi.length != 0 ? Onyomi(resultData.onyomi) : SizedBox.shrink(),
        resultData.kunyomi.length != 0 ? Kunyomi(resultData.kunyomi) : SizedBox.shrink(),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StrokeOrderGif(resultData.strokeOrderGifUri),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("JLPT: ", style: TextStyle(fontSize: 20.0)),
                        JlptLevel(resultData.jlptLevel ?? "⨉"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Grade: ", style: TextStyle(fontSize: 20.0)),
                        Grade(resultData.taughtIn ?? "⨉"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Rank: ", style: TextStyle(fontSize: 20.0)),
                        Rank(resultData.newspaperFrequencyRank ?? -1),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Examples(resultData.onyomiExamples, resultData.kunyomiExamples),
      ],
    );
  }

  KanjiResultCard({required jisho.KanjiResult result}) {

    query = result.query;

    // TODO: Handle this kind of exception before widget is initialized
    if (result.data == null)
      throw Exception();
    
    resultData = result.data!;
  }
}