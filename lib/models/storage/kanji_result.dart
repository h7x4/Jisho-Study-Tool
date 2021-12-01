import 'package:objectbox/objectbox.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

@Entity()
class YomiExample {
  int id = 0;
  String example;
  String reading;
  String meaning;

  YomiExample.fromJishoObject(jisho.YomiExample object)
      : example = object.example,
        reading = object.reading,
        meaning = object.meaning;
}

@Entity()
class Radical {
  int id = 0;
  String symbol;
  List<String> forms;
  String meaning;

  Radical.fromJishoObject(jisho.Radical object)
      : symbol = object.symbol,
        forms = object.forms,
        meaning = object.meaning;
}

@Entity()
class KanjiResult {
  int id = 0;
  String query;
  bool found;
  KanjiResultData? data;

  KanjiResult.fromJishoObject(jisho.KanjiResult object)
      : query = object.query,
        found = object.found,
        data = (object.data == null)
            ? null
            : KanjiResultData.fromJishoObject(object.data!);
}

@Entity()
class KanjiResultData {
  int id = 0;
  String? taughtIn;
  String? jlptLevel;
  int? newspaperFrequencyRank;
  int strokeCount;
  String meaning;
  List<String> kunyomi;
  List<String> onyomi;
  List<YomiExample> kunyomiExamples;
  List<YomiExample> onyomiExamples;
  Radical? radical;
  List<String> parts;
  String strokeOrderDiagramUri;
  String strokeOrderSvgUri;
  String strokeOrderGifUri;
  String uri;

  KanjiResultData.fromJishoObject(jisho.KanjiResultData object)
      : taughtIn = object.taughtIn,
        jlptLevel = object.jlptLevel,
        newspaperFrequencyRank = object.newspaperFrequencyRank,
        strokeCount = object.strokeCount,
        meaning = object.meaning,
        kunyomi = object.kunyomi,
        onyomi = object.onyomi,
        kunyomiExamples = object.kunyomiExamples
            .map((k) => YomiExample.fromJishoObject(k))
            .toList(),
        onyomiExamples = object.onyomiExamples
            .map((o) => YomiExample.fromJishoObject(o))
            .toList(),
        radical = (object.radical == null)
            ? null
            : Radical.fromJishoObject(object.radical!),
        parts = object.parts,
        strokeOrderDiagramUri = object.strokeOrderDiagramUri,
        strokeOrderSvgUri = object.strokeOrderSvgUri,
        strokeOrderGifUri = object.strokeOrderGifUri,
        uri = object.uri;
}
