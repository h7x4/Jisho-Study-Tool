import 'package:objectbox/objectbox.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import 'common.dart';

@Entity()
class ExampleResultData {
  String kanji;
  String kana;
  String english;
  List<ExampleSentencePiece> pieces;

  ExampleResultData.fromJishoObject(jisho.ExampleResultData object)
      : kanji = object.kanji,
        kana = object.kana,
        english = object.english,
        pieces = object.pieces
            .map((p) => ExampleSentencePiece.fromJishoObject(p))
            .toList();
}

@Entity()
class ExampleResults {
  String query;
  bool found;
  String uri;
  List<ExampleResultData> results;

  ExampleResults.fromJishoObject(jisho.ExampleResults object)
      : query = object.query,
        found = object.found,
        uri = object.uri,
        results = object.results
            .map((r) => ExampleResultData.fromJishoObject(r))
            .toList();
}
