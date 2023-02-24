import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../models/library/library_list.dart';
import '../../../services/jisho_api/kanji_furigana_separation.dart';
import '../../../services/kanji_regex.dart';
import '../../../settings.dart';
import '../../library/add_to_library_dialog.dart';
import 'parts/audio_player.dart';
import 'parts/common_badge.dart';
import 'parts/header.dart';
import 'parts/jlpt_badge.dart';
import 'parts/kanji.dart';
import 'parts/links.dart';
import 'parts/notes.dart';
import 'parts/other_forms.dart';
import 'parts/senses.dart';
import 'parts/wanikani_badge.dart';

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
  static const _margin = SizedBox(height: 20);
  PhrasePageScrapeResultData? extraData;

  bool? extraDataSearchFailed;

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

  List<String> get kanji => kanjiRegex
      .allMatches(
        widget.result.japanese
            .map((w) => '${w.word ?? ""}${w.reading ?? ""}')
            .join(),
      )
      .map((match) => match.group(0)!)
      .toSet()
      .toList();

  List<JishoSenseLink> get links =>
      [for (final sense in widget.result.senses) ...sense.links];

  Widget get _header => Row(
        children: [
          Expanded(child: JapaneseHeader(word: widget.mainWord)),
          WKBadge(
            level: widget.result.tags.firstWhere(
              (tag) => tag.contains('wanikani'),
              orElse: () => '',
            ),
          ),
          JLPTBadge(jlptLevel: jlptLevel),
          CommonBadge(isCommon: widget.result.isCommon ?? false)
        ],
      );

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.yellow,
            icon: Icons.star,
            onPressed: (_) => LibraryList.favourites.toggleEntry(
              entryText: widget.result.slug,
              isKanji: false,
            ),
          ),
          SlidableAction(
            backgroundColor: Colors.blue,
            icon: Icons.bookmark,
            onPressed: (context) => showAddToLibraryDialog(
              context: context,
              entryText: widget.result.japanese.first.kanji,
              furigana: widget.result.japanese.first.furigana
            ),
          ),
        ],
      ),
      child: ExpansionTile(
        collapsedBackgroundColor: backgroundColor,
        backgroundColor: backgroundColor,
        onExpansionChanged: (b) async {
          if (extensiveSearchEnabled && extraData == null) {
            final data = await _scrape(widget.result);
            setState(() {
              extraDataSearchFailed = !(data?.found ?? false);
              extraData = !extraDataSearchFailed! ? data!.data : null;
            });
          }
        },
        title: _header,
        children: [
          if (extensiveSearchEnabled && extraDataSearchFailed == null)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (!extraDataSearchFailed!)
            _body(extendedData: extraData)
          else
            _body()
        ],
      ),
    );
  }

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

  Future<PhrasePageScrapeResult?> _scrape(JishoResult result) =>
      (!(result.japanese[0].word == null && result.japanese[0].reading == null))
          ? scrapeForPhrase(
              widget.result.japanese[0].word ??
                  widget.result.japanese[0].reading!,
            )
          : Future(() => null);

  List<Widget> _withMargin(Widget w) => [_margin, w];
}
