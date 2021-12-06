// import 'package:objectbox/objectbox.dart';
// import 'package:unofficial_jisho_api/api.dart' as jisho;

// TODO: Rewrite for sembast

// @Entity()
// class YomiExample {
//   int id;
//   String example;
//   String reading;
//   String meaning;

//   YomiExample({
//     this.id = 0,
//     required this.example,
//     required this.reading,
//     required this.meaning,
//   });

//   YomiExample.fromJishoObject(jisho.YomiExample object)
//       : id = 0,
//         example = object.example,
//         reading = object.reading,
//         meaning = object.meaning;
// }

// @Entity()
// class Radical {
//   int id = 0;
//   String symbol;
//   List<String> forms;
//   String meaning;

//   Radical({
//     this.id = 0,
//     required this.symbol,
//     required this.forms,
//     required this.meaning,
//   });

//   Radical.fromJishoObject(jisho.Radical object)
//       : symbol = object.symbol,
//         forms = object.forms,
//         meaning = object.meaning;
// }

// @Entity()
// class KanjiResult {
//   int id = 0;
//   String query;
//   bool found;
//   KanjiResultData? data;

//   KanjiResult({
//     this.id = 0,
//     required this.query,
//     required this.found,
//     required this.data,
//   });

//   KanjiResult.fromJishoObject(jisho.KanjiResult object)
//       : query = object.query,
//         found = object.found,
//         data = (object.data == null)
//             ? null
//             : KanjiResultData.fromJishoObject(object.data!);
// }

// @Entity()
// class KanjiResultData {
//   int id = 0;
//   String? taughtIn;
//   String? jlptLevel;
//   int? newspaperFrequencyRank;
//   int strokeCount;
//   String meaning;
//   List<String> kunyomi;
//   List<String> onyomi;
//   List<YomiExample> kunyomiExamples;
//   List<YomiExample> onyomiExamples;
//   Radical? radical;
//   List<String> parts;
//   String strokeOrderDiagramUri;
//   String strokeOrderSvgUri;
//   String strokeOrderGifUri;
//   String uri;

//   KanjiResultData({
//     this.id = 0,
//     required this.taughtIn,
//     required this.jlptLevel,
//     required this.newspaperFrequencyRank,
//     required this.strokeCount,
//     required this.meaning,
//     required this.kunyomi,
//     required this.onyomi,
//     required this.kunyomiExamples,
//     required this.onyomiExamples,
//     required this.radical,
//     required this.parts,
//     required this.strokeOrderDiagramUri,
//     required this.strokeOrderSvgUri,
//     required this.strokeOrderGifUri,
//     required this.uri,
//   });

//   KanjiResultData.fromJishoObject(jisho.KanjiResultData object)
//       : taughtIn = object.taughtIn,
//         jlptLevel = object.jlptLevel,
//         newspaperFrequencyRank = object.newspaperFrequencyRank,
//         strokeCount = object.strokeCount,
//         meaning = object.meaning,
//         kunyomi = object.kunyomi,
//         onyomi = object.onyomi,
//         kunyomiExamples = object.kunyomiExamples
//             .map((k) => YomiExample.fromJishoObject(k))
//             .toList(),
//         onyomiExamples = object.onyomiExamples
//             .map((o) => YomiExample.fromJishoObject(o))
//             .toList(),
//         radical = (object.radical == null)
//             ? null
//             : Radical.fromJishoObject(object.radical!),
//         parts = object.parts,
//         strokeOrderDiagramUri = object.strokeOrderDiagramUri,
//         strokeOrderSvgUri = object.strokeOrderSvgUri,
//         strokeOrderGifUri = object.strokeOrderGifUri,
//         uri = object.uri;
// }
