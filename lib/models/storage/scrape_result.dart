// import 'package:objectbox/objectbox.dart';
// import 'package:unofficial_jisho_api/api.dart' as jisho;

// import 'common.dart';

// TODO: Rewrite for sembast

// @Entity()
// class PhraseScrapeSentence {
//   int id;
//   String english;
//   String japanese;
//   List<ExampleSentencePiece> pieces;

//   PhraseScrapeSentence({
//     this.id = 0,
//     required this.english,
//     required this.japanese,
//     required this.pieces,
//   });

//   PhraseScrapeSentence.fromJishoObject(jisho.PhraseScrapeSentence object)
//       : id = 0,
//         english = object.english,
//         japanese = object.japanese,
//         pieces = object.pieces
//             .map((p) => ExampleSentencePiece.fromJishoObject(p))
//             .toList();
// }

// @Entity()
// class PhraseScrapeMeaning {
//   int id;
//   List<String> seeAlsoTerms;
//   List<PhraseScrapeSentence> sentences;
//   String definition;
//   List<String> supplemental;
//   String? definitionAbstract;
//   List<String> tags;

//   PhraseScrapeMeaning({
//     this.id = 0,
//     required this.seeAlsoTerms,
//     required this.sentences,
//     required this.definition,
//     required this.supplemental,
//     required this.definitionAbstract,
//     required this.tags,
//   });

//   PhraseScrapeMeaning.fromJishoObject(jisho.PhraseScrapeMeaning object)
//       : id = 0,
//         seeAlsoTerms = object.seeAlsoTerms,
//         sentences = object.sentences
//             .map((s) => PhraseScrapeSentence.fromJishoObject(s))
//             .toList(),
//         definition = object.definition,
//         supplemental = object.supplemental,
//         definitionAbstract = object.definitionAbstract,
//         tags = object.tags;
// }

// @Entity()
// class KanjiKanaPair {
//   int id;
//   String kanji;
//   String? kana;

//   KanjiKanaPair({
//     this.id = 0,
//     required this.kanji,
//     required this.kana,
//   });

//   KanjiKanaPair.fromJishoObject(jisho.KanjiKanaPair object)
//       : id = 0,
//         kanji = object.kanji,
//         kana = object.kana;
// }

// @Entity()
// class PhrasePageScrapeResult {
//   int id;
//   bool found;
//   String query;
//   PhrasePageScrapeResultData? data;

//   PhrasePageScrapeResult({
//     this.id = 0,
//     required this.found,
//     required this.query,
//     required this.data,
//   });

//   PhrasePageScrapeResult.fromJishoObject(jisho.PhrasePageScrapeResult object)
//       : id = 0,
//         found = object.found,
//         query = object.query,
//         data = (object.data == null)
//             ? null
//             : PhrasePageScrapeResultData.fromJishoObject(object.data!);
// }

// @Entity()
// class AudioFile {
//   int id;
//   String uri;
//   String mimetype;

//   AudioFile({
//     this.id = 0,
//     required this.uri,
//     required this.mimetype,
//   });

//   AudioFile.fromJishoObject(jisho.AudioFile object)
//       : id = 0,
//         uri = object.uri,
//         mimetype = object.mimetype;
// }

// @Entity()
// class PhrasePageScrapeResultData {
//   int id;
//   String uri;
//   List<String> tags;
//   List<PhraseScrapeMeaning> meanings;
//   List<KanjiKanaPair> otherForms;
//   List<AudioFile> audio;
//   List<String> notes;

//   PhrasePageScrapeResultData({
//     this.id = 0,
//     required this.uri,
//     required this.tags,
//     required this.meanings,
//     required this.otherForms,
//     required this.audio,
//     required this.notes,
//   });

//   PhrasePageScrapeResultData.fromJishoObject(
//     jisho.PhrasePageScrapeResultData object,
//   )   : id = 0,
//         uri = object.uri,
//         tags = object.tags,
//         meanings = object.meanings
//             .map((m) => PhraseScrapeMeaning.fromJishoObject(m))
//             .toList(),
//         otherForms = object.otherForms
//             .map((f) => KanjiKanaPair.fromJishoObject(f))
//             .toList(),
//         audio = object.audio.map((a) => AudioFile.fromJishoObject(a)).toList(),
//         notes = object.notes;
// }
