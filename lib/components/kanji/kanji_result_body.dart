import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import './kanji_result_body/examples.dart';
import './kanji_result_body/grade.dart';
import './kanji_result_body/jlpt_level.dart';
import './kanji_result_body/radical.dart';
import './kanji_result_body/rank.dart';
import './kanji_result_body/stroke_order_gif.dart';
import './kanji_result_body/yomi_chips.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../services/kanji_grade_conversion.dart';
import '../common/kanji_box.dart';

class KanjiResultBody extends StatelessWidget {
  late final String query;
  late final jisho.KanjiResultData resultData;

  KanjiResultBody({required jisho.KanjiResult result, Key? key})
      : super(key: key) {
    query = result.query;

    // TODO: Handle this kind of exception before widget is initialized
    if (result.data == null) throw Exception();

    resultData = result.data!;
  }

  // TODO: add compart link
  Widget get headerRow => Container(
        margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
            Flexible(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      final colors = state.theme.kanjiResultColor;
                      return KanjiBox.expanded(
                        kanji: query,
                        ratio: 40,
                        foreground: colors.foreground,
                        background: colors.background,
                      );
                    },
                  ),
                ),
              ),
            
            Flexible(
              fit: FlexFit.tight,
              child: Center(
                child: (resultData.radical != null)
                    ? Radical(radical: resultData.radical!)
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      );

  Widget get rankingColumn => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('JLPT: ', style: TextStyle(fontSize: 20.0)),
              JlptLevel(jlptLevel: resultData.jlptLevel ?? '⨉'),
            ],
          ),
          Row(
            children: [
              const Text('Grade: ', style: TextStyle(fontSize: 20.0)),
              Grade(grade: resultData.grade),
            ],
          ),
          Row(
            children: [
              const Text('Rank: ', style: TextStyle(fontSize: 20.0)),
              Rank(rank: resultData.newspaperFrequencyRank),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        headerRow,
        // TODO: handle case where meaning is empty. See 牃 for example
        YomiChips(yomi: resultData.meaning.split(', '), type: YomiType.meaning),
        (resultData.onyomi.isNotEmpty)
            ? YomiChips(yomi: resultData.onyomi, type: YomiType.onyomi)
            : const SizedBox.shrink(),
        (resultData.kunyomi.isNotEmpty)
            ? YomiChips(yomi: resultData.kunyomi, type: YomiType.kunyomi)
            : const SizedBox.shrink(),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StrokeOrderGif(uri: resultData.strokeOrderGifUri),
              rankingColumn,
            ],
          ),
        ),
        Examples(
          onyomi: resultData.onyomiExamples,
          kunyomi: resultData.kunyomiExamples,
        ),
        // TODO: Add unicode information
      ],
    );
  }
}
