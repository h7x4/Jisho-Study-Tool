import 'package:objectbox/objectbox.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

@Entity()
class SearchResult {
  int id = 0;
  final JishoResultMeta meta;
  final ToMany<JishoResult> data = ToMany<JishoResult>();

  SearchResult.fromJishoObject(final jisho.JishoAPIResult object)
      : meta = JishoResultMeta.fromJishoObject(object.meta) {
    data.addAll(
      object.data
              ?.map((r) => JishoResult.fromJishoObject(r)) ??
          <JishoResult>[],
    );
  }
}

@Entity()
class JishoResultMeta {
  int id = 0;
  int status;

  JishoResultMeta.fromJishoObject(final jisho.JishoResultMeta object)
      : status = object.status;
}

@Entity()
class JishoResult {
  int id = 0;
  JishoAttribution attribution;
  bool? is_common;
  List<JishoJapaneseWord> japanese;
  List<String> jlpt;
  List<JishoWordSense> senses;
  String slug;
  List<String> tags;

  JishoResult.fromJishoObject(final jisho.JishoResult object)
      : attribution = JishoAttribution.fromJishoObject(object.attribution),
        is_common = object.isCommon,
        japanese = object.japanese
            .map((j) => JishoJapaneseWord.fromJishoObject(j))
            .toList(),
        jlpt = object.jlpt,
        senses = object.senses
            .map((s) => JishoWordSense.fromJishoObject(s))
            .toList(),
        slug = object.slug,
        tags = object.tags;
}

@Entity()
class JishoAttribution {
  int id = 0;
  String? dbpedia;
  bool jmdict;
  bool jmnedict;

  JishoAttribution.fromJishoObject(final jisho.JishoAttribution object)
      : dbpedia = object.dbpedia,
        jmdict = object.jmdict,
        jmnedict = object.jmnedict;
}

@Entity()
class JishoJapaneseWord {
  int id = 0;
  String? reading;
  String? word;

  JishoJapaneseWord.fromJishoObject(final jisho.JishoJapaneseWord object)
      : reading = object.reading,
        word = object.word;
}

@Entity()
class JishoWordSense {
  int id = 0;
  List<String> antonyms;
  List<String> english_definitions;
  List<String> info;
  List<JishoSenseLink> links;
  List<String> parts_of_speech;
  List<String> restrictions;
  List<String> see_also;
  List<JishoWordSource> source;
  List<String> tags;

  JishoWordSense.fromJishoObject(final jisho.JishoWordSense object)
      : antonyms = object.antonyms,
        english_definitions = object.englishDefinitions,
        info = object.info,
        links =
            object.links.map((l) => JishoSenseLink.fromJishoObject(l)).toList(),
        parts_of_speech = object.partsOfSpeech,
        restrictions = object.restrictions,
        see_also = object.seeAlso,
        source = object.source
            .map((s) => JishoWordSource.fromJishoObject(s))
            .toList(),
        tags = object.tags;
}

@Entity()
class JishoWordSource {
  int id = 0;
  String language;
  String? word;

  JishoWordSource.fromJishoObject(final jisho.JishoWordSource object)
      : language = object.language,
        word = object.word;
}

@Entity()
class JishoSenseLink {
  int id = 0;
  String text;
  String url;

  JishoSenseLink.fromJishoObject(final jisho.JishoSenseLink object)
      : text = object.text,
        url = object.url;
}
