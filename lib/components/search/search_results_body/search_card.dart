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
      widget.result.senses.map((s) => s.links).expand((l) => l).toList();

  bool get hasAttribution =>
      widget.result.attribution.jmdict ||
      widget.result.attribution.jmnedict ||
      (widget.result.attribution.dbpedia != null);

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
                // TODO: find the lowest level in the list.
                JLPTBadge(
                  jlptLevel:
                      widget.result.jlpt.isEmpty ? null : widget.result.jlpt[0],
                ),
                CommonBadge(isCommon: widget.result.isCommon ?? false)
              ],
            )
          ],
        ),
      );

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

            if (widget.otherForms.isNotEmpty) ...[
              const SizedBox(height: 20),
              OtherForms(forms: widget.otherForms),
            ],

            if (extendedData != null && extendedData.notes.isNotEmpty) ...[
              const SizedBox(height: 20),
              Notes(notes: extendedData.notes),
            ],

            if (links.isNotEmpty || hasAttribution) ...[
              const SizedBox(height: 20),
              Links(
                links: links,
                attribution: widget.result.attribution,
              ),
            ]
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
