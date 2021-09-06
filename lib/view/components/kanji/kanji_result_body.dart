import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import './kanji_result_body/examples.dart';
import './kanji_result_body/grade.dart';
import './kanji_result_body/header.dart';
import './kanji_result_body/jlpt_level.dart';
import './kanji_result_body/radical.dart';
import './kanji_result_body/rank.dart';
import './kanji_result_body/stroke_order_gif.dart';
import './kanji_result_body/yomi_chips.dart';

class KanjiResultBody extends StatelessWidget {
  late final String query;
  late final jisho.KanjiResultData resultData;

  KanjiResultBody({required jisho.KanjiResult result}) {

    query = result.query;

    // TODO: Handle this kind of exception before widget is initialized
    if (result.data == null)
      throw Exception();
    
    resultData = result.data!;
  }

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
        YomiChips(resultData.meaning.split(', '), YomiType.meaning),
        resultData.onyomi.length != 0 ? YomiChips(resultData.onyomi, YomiType.onyomi) : SizedBox.shrink(),
        resultData.kunyomi.length != 0 ? YomiChips(resultData.kunyomi, YomiType.kunyomi) : SizedBox.shrink(),
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
}