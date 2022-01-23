import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import './parts/common_badge.dart';
import './parts/header.dart';
import './parts/jlpt_badge.dart';
import './parts/other_forms.dart';
import './parts/senses.dart';
import './parts/wanikani_badge.dart';
import '../../../settings.dart';
import 'parts/audio_player.dart';
import 'parts/kanji.dart';
import 'parts/links.dart';
import 'parts/notes.dart';

class SearchResultCard extends StatefulWidget {
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
  _SearchResultCardState createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {
  PhrasePageScrapeResultData? extraData;

  Future<PhrasePageScrapeResult?> _scrape(JishoResult result) =>
      (!(result.japanese[0].word == null && result.japanese[0].reading == null))
          ? scrapeForPhrase(
              widget.result.japanese[0].word ??
                  widget.result.japanese[0].reading!,
            )
          : Future(() => null);

  List<JishoSenseLink> get links =>
      [for (final sense in widget.result.senses) ...sense.links];

  bool get hasAttribution =>
      widget.result.attribution.jmdict ||
      widget.result.attribution.jmnedict ||
      (widget.result.attribution.dbpedia != null);

  String? get jlptLevel {
    if (widget.result.jlpt.isEmpty) return null;
    final jlpt = List.from(widget.result.jlpt);
    jlpt.sort();
    return jlpt.last;
  }

  List<String> get kanji => RegExp(r'(\p{Script=Hani})', unicode: true)
      .allMatches(
        widget.result.japanese
            .map((w) => '${w.word ?? ""}${w.reading ?? ""}')
            .join(),
      )
      .map((match) => match.group(0)!)
      .toSet()
      .toList();

  Widget get _header => IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            JapaneseHeader(word: widget.mainWord),
            Row(
              children: [
                WKBadge(
                  level: widget.result.tags.firstWhere(
                    (tag) => tag.contains('wanikani'),
                    orElse: () => '',
                  ),
                ),
                JLPTBadge(jlptLevel: jlptLevel),
                CommonBadge(isCommon: widget.result.isCommon ?? false)
              ],
            )
          ],
        ),
      );

  static const _margin = SizedBox(height: 20);

  List<Widget> _withMargin(Widget w) => [_margin, w];

  Widget _body({PhrasePageScrapeResultData? extendedData}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (extendedData != null && extendedData.audio.isNotEmpty) ...[
              // TODO: There's usually multiple mimetypes in the data.
              //       If one mimetype fails, the app should try to use another one.
              AudioPlayer(audio: extendedData.audio.first),
              const SizedBox(height: 10),
            ],
            Senses(
              senses: widget.result.senses,
              extraData: extendedData?.meanings,
            ),
            if (widget.otherForms.isNotEmpty)
              ..._withMargin(OtherForms(forms: widget.otherForms)),
            if (extendedData != null && extendedData.notes.isNotEmpty)
              ..._withMargin(Notes(notes: extendedData.notes)),
            if (kanji.isNotEmpty) ..._withMargin(KanjiRow(kanji: kanji)),
            if (links.isNotEmpty || hasAttribution)
              ..._withMargin(
                Links(
                  links: links,
                  attribution: widget.result.attribution,
                ),
              )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return ExpansionTile(
      collapsedBackgroundColor: backgroundColor,
      backgroundColor: backgroundColor,
      onExpansionChanged: (b) async {
        if (extensiveSearchEnabled && extraData == null) {
          final data = await _scrape(widget.result);
          setState(() {
            extraData = (data != null && data.found) ? data.data : null;
          });
        }
      },
      title: _header,
      children: [
        if (extensiveSearchEnabled && extraData == null)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (extraData != null)
          _body(extendedData: extraData)
        else
          _body()
      ],
    );
  }
}
