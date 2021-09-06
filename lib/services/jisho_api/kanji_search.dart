import 'package:unofficial_jisho_api/api.dart' as jisho;
export 'package:unofficial_jisho_api/api.dart' show KanjiResult;

String? _convertGrade(String grade) {
  const conversionTable = {
    "grade 1": "小1",
    "grade 2": "小2",
    "grade 3": "小3",
    "grade 4": "小4",
    "grade 5": "小5",
    "grade 6": "小6",
    "junior high": "中"
  };

  print('conversion run: $grade -> ${conversionTable[grade]}');

  return conversionTable[grade];
}

// TODO: fix this logic

Future<jisho.KanjiResult> fetchKanji(String kanji) async {
  final result = await jisho.searchForKanji(kanji);
  if (result.data != null && result.data?.taughtIn != null)
    result.data!.taughtIn = _convertGrade(result.data!.taughtIn!);
  return result;
}