import 'package:unofficial_jisho_api/api.dart' as jisho;

String _convertGrade(String grade) {
  const _conversionTable = {
    "grade 1": "小1",
    "grade 2": "小2",
    "grade 3": "小3",
    "grade 4": "小4",
    "grade 5": "小5",
    "grade 6": "小6",
    "junior high": "中"
  };

  print('conversion run: $grade -> ${_conversionTable[grade]}');

  return _conversionTable[grade];
}

Future<jisho.KanjiResult> fetchKanji(String kanji) async {
  final result = await jisho.searchForKanji(kanji);
  result.taughtIn = _convertGrade(result.taughtIn);
  return result;
}