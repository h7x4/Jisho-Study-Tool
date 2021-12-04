// import 'package:objectbox/objectbox.dart';
// import 'package:unofficial_jisho_api/api.dart' as jisho;

// import 'common.dart';

// TODO: Rewrite for sembast

// @Entity()
// class ExampleResultData {
//   int id;
//   String kanji;
//   String kana;
//   String english;
//   List<ExampleSentencePiece> pieces;

//   ExampleResultData({
//     this.id = 0,
//     required this.kanji,
//     required this.kana,
//     required this.english,
//     required this.pieces,
//   });

//   ExampleResultData.fromJishoObject(jisho.ExampleResultData object)
//       : id = 0,
//         kanji = object.kanji,
//         kana = object.kana,
//         english = object.english,
//         pieces = object.pieces
//             .map((p) => ExampleSentencePiece.fromJishoObject(p))
//             .toList();
// }

// @Entity()
// class ExampleResults {
//   int id;
//   String query;
//   bool found;
//   String uri;
//   List<ExampleResultData> results;

//   ExampleResults({
//     this.id = 0,
//     required this.query,
//     required this.found,
//     required this.uri,
//     required this.results,
//   });

//   ExampleResults.fromJishoObject(jisho.ExampleResults object)
//       : id = 0,
//         query = object.query,
//         found = object.found,
//         uri = object.uri,
//         results = object.results
//             .map((r) => ExampleResultData.fromJishoObject(r))
//             .toList();
// }
