// import 'package:objectbox/objectbox.dart';
// import 'package:unofficial_jisho_api/api.dart' as jisho;

// TODO: Rewrite for sembast

// @Entity()
// class SearchResult {
//   int id;
//   final JishoResultMeta meta;
//   final ToMany<JishoResult> data;

//   SearchResult({
//     this.id = 0,
//     required this.meta,
//     required this.data,
//   });

//   SearchResult.fromJishoObject(final jisho.JishoAPIResult object)
//       : id = 0,
//         meta = JishoResultMeta.fromJishoObject(object.meta),
//         data = ToMany<JishoResult>()
//           ..addAll(
//             object.data?.map((r) => JishoResult.fromJishoObject(r)) ??
//                 <JishoResult>[],
//           );
// }

// @Entity()
// class JishoResultMeta {
//   int id;
//   int status;

//   JishoResultMeta({
//     this.id = 0,
//     required this.status,
//   });

//   JishoResultMeta.fromJishoObject(final jisho.JishoResultMeta object)
//       : id = 0,
//         status = object.status;
// }

// @Entity()
// class JishoResult {
//   int id;
//   JishoAttribution attribution;
//   bool? is_common;
//   List<JishoJapaneseWord> japanese;
//   List<String> jlpt;
//   List<JishoWordSense> senses;
//   String slug;
//   List<String> tags;

//   JishoResult({
//     this.id = 0,
//     required this.attribution,
//     required this.is_common,
//     required this.japanese,
//     required this.jlpt,
//     required this.senses,
//     required this.slug,
//     required this.tags,
//   });

//   JishoResult.fromJishoObject(final jisho.JishoResult object)
//       : id = 0,
//         attribution = JishoAttribution.fromJishoObject(object.attribution),
//         is_common = object.isCommon,
//         japanese = object.japanese
//             .map((j) => JishoJapaneseWord.fromJishoObject(j))
//             .toList(),
//         jlpt = object.jlpt,
//         senses = object.senses
//             .map((s) => JishoWordSense.fromJishoObject(s))
//             .toList(),
//         slug = object.slug,
//         tags = object.tags;
// }

// @Entity()
// class JishoAttribution {
//   int id;
//   String? dbpedia;
//   bool jmdict;
//   bool jmnedict;

//   JishoAttribution({
//     this.id = 0,
//     required this.dbpedia,
//     required this.jmdict,
//     required this.jmnedict,
//   });

//   JishoAttribution.fromJishoObject(final jisho.JishoAttribution object)
//       : id = 0,
//         dbpedia = object.dbpedia,
//         jmdict = object.jmdict,
//         jmnedict = object.jmnedict;
// }

// @Entity()
// class JishoJapaneseWord {
//   int id;
//   String? reading;
//   String? word;

//   JishoJapaneseWord({
//     this.id = 0,
//     required this.reading,
//     required this.word,
//   });

//   JishoJapaneseWord.fromJishoObject(final jisho.JishoJapaneseWord object)
//       : id = 0,
//         reading = object.reading,
//         word = object.word;
// }

// @Entity()
// class JishoWordSense {
//   int id;
//   List<String> antonyms;
//   List<String> english_definitions;
//   List<String> info;
//   List<JishoSenseLink> links;
//   List<String> parts_of_speech;
//   List<String> restrictions;
//   List<String> see_also;
//   List<JishoWordSource> source;
//   List<String> tags;

//   JishoWordSense({
//     this.id = 0,
//     required this.antonyms,
//     required this.english_definitions,
//     required this.info,
//     required this.links,
//     required this.parts_of_speech,
//     required this.restrictions,
//     required this.see_also,
//     required this.source,
//     required this.tags,
//   });

//   JishoWordSense.fromJishoObject(final jisho.JishoWordSense object)
//       : id = 0,
//         antonyms = object.antonyms,
//         english_definitions = object.englishDefinitions,
//         info = object.info,
//         links =
//             object.links.map((l) => JishoSenseLink.fromJishoObject(l)).toList(),
//         parts_of_speech = object.partsOfSpeech,
//         restrictions = object.restrictions,
//         see_also = object.seeAlso,
//         source = object.source
//             .map((s) => JishoWordSource.fromJishoObject(s))
//             .toList(),
//         tags = object.tags;
// }

// @Entity()
// class JishoWordSource {
//   int id;
//   String language;
//   String? word;

//   JishoWordSource({
//     this.id = 0,
//     required this.language,
//     required this.word,
//   });

//   JishoWordSource.fromJishoObject(final jisho.JishoWordSource object)
//       : id = 0,
//         language = object.language,
//         word = object.word;
// }

// @Entity()
// class JishoSenseLink {
//   int id;
//   String text;
//   String url;

//   JishoSenseLink({
//     this.id = 0,
//     required this.text,
//     required this.url,
//   });

//   JishoSenseLink.fromJishoObject(final jisho.JishoSenseLink object)
//       : id = 0,
//         text = object.text,
//         url = object.url;
// }
